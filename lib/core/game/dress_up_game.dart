import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../repositories/asset_repository.dart';
import '../services/character_service.dart';
import '../services/sprite_cache_service.dart';
import 'components/character_component.dart';

class DressUpGame extends FlameGame {
  late CharacterService _characterService;
  final SpriteCacheService _spriteCacheService = SpriteCacheService();
  CharacterComponent? _characterComponent;
  bool _isInitialized = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugPrint('DressUpGame: Starting initialization...');
    
    // Initialize services
    _characterService = CharacterService(AssetRepositoryImpl());
    
    
    await _initializeGame();
  }

  Future<void> _initializeGame() async {
    try {
      debugPrint('DressUpGame: Initializing character service...');
      await _characterService.initialize();
      debugPrint('DressUpGame: Character service initialized successfully');
      
      // Preload all sprites
      debugPrint('DressUpGame: Starting sprite preloading...');
      final allAssets = await AssetRepositoryImpl().loadMetadata();
      await _spriteCacheService.preloadSprites(allAssets);
      debugPrint('DressUpGame: Sprite preloading completed');
      
      // Create character component
      debugPrint('DressUpGame: Creating character component...');
      _characterComponent = CharacterComponent(_characterService, _spriteCacheService);
      add(_characterComponent!);
      debugPrint('DressUpGame: Character component added');
      
      _isInitialized = true;
      debugPrint('DressUpGame: Initialization completed successfully!');
    } catch (e) {
      debugPrint('DressUpGame: Failed to initialize game: $e');
      debugPrint('DressUpGame: Stack trace: ${StackTrace.current}');
    }
  }

  CharacterService get characterService => _characterService;
  SpriteCacheService get spriteCacheService => _spriteCacheService;
  
  bool get isInitialized => _isInitialized;
  double get loadingProgress => _spriteCacheService.loadingProgress;

  void updateCharacter() {
    debugPrint('DressUpGame: updateCharacter called');
    if (_characterComponent != null) {
      debugPrint('DressUpGame: Calling updateCharacterDisplay on character component');
      _characterComponent!.updateCharacterDisplay();
    } else {
      debugPrint('DressUpGame: Warning - character component is null!');
    }
  }

  @override
  void onRemove() {
    _spriteCacheService.dispose();
    super.onRemove();
  }
} 