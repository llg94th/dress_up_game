import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide AssetMetadata;
import 'dart:ui' as ui;
import '../models/asset_metadata.dart';
import '../repositories/asset_repository.dart';

class SpriteCacheService {

  SpriteCacheService._();

  static final SpriteCacheService _instance = SpriteCacheService._();
  static SpriteCacheService get instance => _instance;

  final Map<String, Sprite> _spriteCache = {};
  int _totalAssets = 0;
  int _loadedAssets = 0;
  
  bool get isLoaded => _loadedAssets == _totalAssets && _totalAssets > 0;
  bool get isLoading => _isLoading;
  bool _isLoading = false;
  final Completer<void> _preloadCompleter = Completer<void>();

  final StreamController<double> _loadingProgressController = StreamController<double>.broadcast();
  Stream<double> get loadingProgressStream => _loadingProgressController.stream;
  
  Future<void> preloadSprites() async {
    if (_isLoading) return _preloadCompleter.future;
    if (_preloadCompleter.isCompleted) return _preloadCompleter.future;
    if (isLoaded) return _preloadCompleter.future;
    final allAssets = await AssetRepositoryImpl().loadMetadata();
    debugPrint('SpriteCacheService: Starting preload of ${allAssets.length} sprites...');
    _isLoading = true;

    _totalAssets = allAssets.length;
    _loadedAssets = 0;
    _loadingProgressController.add(0.0);
    _spriteCache.clear();
    
    // Load sprites in batches to avoid memory spikes
    const batchSize = 10;
    for (int i = 0; i < allAssets.length; i += batchSize) {
      final batch = allAssets.skip(i).take(batchSize).toList();
      await _loadBatch(batch);
      debugPrint('SpriteCacheService: Loaded batch ${(i / batchSize).floor() + 1}/${(allAssets.length / batchSize).ceil()} ($_loadedAssets/$_totalAssets)');
    }
    
    debugPrint('SpriteCacheService: Preloading completed! Cached ${_spriteCache.length} sprites');
    _isLoading = false;
    _preloadCompleter.complete();
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
      _loadingProgressController.add(_loadedAssets / _totalAssets);
    } catch (e) {
      debugPrint('SpriteCacheService: Failed to load ${metadata.flutterPath}: $e');
      _loadedAssets++; // Still count as processed to maintain progress accuracy
      _loadingProgressController.add(_loadedAssets / _totalAssets);
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
    _loadingProgressController.close();

  }
} 