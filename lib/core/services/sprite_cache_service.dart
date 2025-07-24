import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide AssetMetadata;
import 'dart:ui' as ui;
import '../models/asset_metadata.dart';

class SpriteCacheService {
  final Map<String, Sprite> _spriteCache = {};
  int _totalAssets = 0;
  int _loadedAssets = 0;
  
  double get loadingProgress => _totalAssets > 0 ? _loadedAssets / _totalAssets : 0.0;
  bool get isLoaded => _loadedAssets == _totalAssets && _totalAssets > 0;
  
  Future<void> preloadSprites(List<AssetMetadata> allAssets) async {
    debugPrint('SpriteCacheService: Starting preload of ${allAssets.length} sprites...');
    
    _totalAssets = allAssets.length;
    _loadedAssets = 0;
    _spriteCache.clear();
    
    // Load sprites in batches to avoid memory spikes
    const batchSize = 10;
    for (int i = 0; i < allAssets.length; i += batchSize) {
      final batch = allAssets.skip(i).take(batchSize).toList();
      await _loadBatch(batch);
      debugPrint('SpriteCacheService: Loaded batch ${(i / batchSize).floor() + 1}/${(allAssets.length / batchSize).ceil()} (${_loadedAssets}/${_totalAssets})');
    }
    
    debugPrint('SpriteCacheService: Preloading completed! Cached ${_spriteCache.length} sprites');
  }
  
  Future<void> _loadBatch(List<AssetMetadata> batch) async {
    final futures = batch.map((metadata) => _loadSprite(metadata));
    await Future.wait(futures);
  }
  
  Future<void> _loadSprite(AssetMetadata metadata) async {
    try {
      final assetPath = 'assets/images/${metadata.flutterPath}.png';
      final bytes = await rootBundle.load(assetPath);
      final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      final image = frame.image;
      
      final sprite = Sprite(image);
      _spriteCache[metadata.flutterPath] = sprite;
      _loadedAssets++;
      
    } catch (e) {
      debugPrint('SpriteCacheService: Failed to load ${metadata.flutterPath}: $e');
      _loadedAssets++; // Still count as processed to maintain progress accuracy
    }
  }
  
  Sprite? getSprite(String flutterPath) {
    return _spriteCache[flutterPath];
  }
  
  bool hasSprite(String flutterPath) {
    return _spriteCache.containsKey(flutterPath);
  }
  
  void dispose() {
    debugPrint('SpriteCacheService: Disposing ${_spriteCache.length} cached sprites');
    _spriteCache.clear();
    _totalAssets = 0;
    _loadedAssets = 0;
  }
} 