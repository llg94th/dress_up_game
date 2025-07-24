import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../models/asset_metadata.dart';
import '../../services/character_service.dart';
import '../../services/sprite_cache_service.dart';

class CharacterComponent extends Component {
  final CharacterService _characterService;
  final SpriteCacheService _spriteCacheService;
  final List<SpriteComponent> _layerComponents = [];
  late Vector2 _characterPosition;
  late Vector2 _characterSize;
  late double _baseScale;
  
  CharacterComponent(this._characterService, this._spriteCacheService);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Calculate positioning and scale
    final game = findGame()!;
    final screenCenter = game.size / 2;
    
    // Set base scale to fit character nicely on screen
    _baseScale = 0.4; // Adjust this value as needed
    
    // Initialize with default canvas size from metadata
    // All images should have the same canvas size (e.g., 2894x2096)
    const defaultCanvasWidth = 2894.0;
    const defaultCanvasHeight = 2096.0;
    
    _characterSize = Vector2(
      defaultCanvasWidth * _baseScale,
      defaultCanvasHeight * _baseScale,
    );
    
    // Center the character on screen
    _characterPosition = Vector2(
      screenCenter.x - (_characterSize.x / 2),
      screenCenter.y - (_characterSize.y / 2),
    );
    
    await updateCharacterDisplay();
  }

  Future<void> updateCharacterDisplay() async {
    debugPrint('CharacterComponent: Starting character update...');
    
    // Remove existing components
    debugPrint('CharacterComponent: Removing ${_layerComponents.length} existing components');
    for (final component in _layerComponents) {
      remove(component);
    }
    _layerComponents.clear();

    // Get all visible layers (including base body if visible)
    final currentLayers = _characterService.getCurrentCharacterLayers();
    debugPrint('CharacterComponent: Found ${currentLayers.length} visible layers');
    
    // Add all visible layers in correct order using cached sprites
    for (final layer in currentLayers) {
      await _addCachedLayer(layer);
    }
    
    debugPrint('CharacterComponent: Character update completed with ${_layerComponents.length} components');
  }

  Future<void> _addCachedLayer(AssetMetadata metadata) async {
    try {
      // Get sprite from cache (instant access)
      final sprite = _spriteCacheService.getSprite(metadata.flutterPath);
      
      if (sprite == null) {
        debugPrint('CharacterComponent: Sprite not found in cache: ${metadata.flutterPath}');
        return;
      }
      
      debugPrint('CharacterComponent: Adding cached sprite: ${metadata.flutterPath}');
      
      // Create sprite component with cached sprite (no loading time)
      final spriteComponent = SpriteComponent(
        sprite: sprite,
        position: _characterPosition,
        size: _characterSize,
      );

      // Add to game and track
      add(spriteComponent);
      _layerComponents.add(spriteComponent);
      
      debugPrint('CharacterComponent: Successfully added sprite component for ${metadata.flutterPath}');
    } catch (e) {
      debugPrint('CharacterComponent: Failed to add cached sprite: ${metadata.flutterPath} - $e');
    }
  }
} 