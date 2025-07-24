import '../models/asset_metadata.dart';
import '../models/character_layer.dart';
import '../repositories/asset_repository.dart';
import 'package:flutter/material.dart';

class CharacterService {
  final AssetRepository _repository;
  Map<String, CharacterLayer> _layers = {};
  
  // Layer order để hiển thị đúng thứ tự như PSD (từ dưới lên trên)
  static const List<String> _layerOrder = [
    'hair_behind',      // Dưới cùng
    'base_body',        // Base layer
    'blush',
    'costume',
    'hair_front',
    'expression',
    'accessories_front',
    'hand_gesture',
    'ahoge',            // Trên cùng
  ];

  CharacterService(this._repository);

  Future<void> initialize() async {
    debugPrint('CharacterService: Starting initialization...');
    final groupedAssets = await _repository.groupAssetsByType();
    
    debugPrint('CharacterService: Found groups: ${groupedAssets.keys.toList()}');
    
    _layers = {};
    for (final entry in groupedAssets.entries) {
      // Set default visibility for specific layers
      int initialIndex;
      if (entry.key == 'base_body' || entry.key == 'costume') {
        initialIndex = 0; // base_body and costume visible by default
      }
      else if (entry.key == 'hair_front') {
        initialIndex = 1; // hair_front visible by default
      } else if (entry.key == 'hair_behind') {
        initialIndex = 3; // hair_behind visible by default
      } else if (entry.key == 'blush') {
        initialIndex = 0; // blush visible by default
      } else if (entry.key == 'expression') {
        initialIndex = 0; // expression visible by default
      } else if (entry.key == 'accessories_front') {
        initialIndex = 0; // accessories_front visible by default
      }
       else {
        initialIndex = -1; // other layers hidden by default
      }
      
      _layers[entry.key] = CharacterLayer(
        groupName: entry.key,
        items: entry.value,
        selectedIndex: initialIndex,
      );
      
      debugPrint('CharacterService: Created layer "${entry.key}" with ${entry.value.length} items, selectedIndex: $initialIndex');
      
      if (entry.key == 'base_body' || entry.key == 'costume') {
        final layer = _layers[entry.key]!;
        debugPrint('CharacterService: ${entry.key} layer - isVisible: ${layer.isVisible}, selectedItem: ${layer.selectedItem?.flutterPath}');
      }
    }
    
    debugPrint('CharacterService: Initialization completed with ${_layers.length} layers');
  }

  Map<String, CharacterLayer> get layers => Map.unmodifiable(_layers);

  // Use display order for UI controls
  List<String> get availableGroups => _layerOrder
      .where((group) => _layers.containsKey(group))
      .toList();

  CharacterLayer? getLayer(String groupName) => _layers[groupName];

  void selectItemInGroup(String groupName, int index) {
    _layers[groupName]?.selectIndex(index);
  }

  void selectNextInGroup(String groupName) {
    _layers[groupName]?.selectNext();
  }

  void selectPreviousInGroup(String groupName) {
    _layers[groupName]?.selectPrevious();
  }

  void hideLayer(String groupName) {
    _layers[groupName]?.hide();
  }

  void showLayer(String groupName) {
    _layers[groupName]?.show();
  }

  // Use layer order for correct rendering
  List<AssetMetadata> getCurrentCharacterLayers() {
    final List<AssetMetadata> currentLayers = [];
    
    for (final groupName in _layerOrder) {
      final layer = _layers[groupName];
      // Only add visible layers
      if (layer != null && layer.isVisible) {
        final selectedItem = layer.selectedItem;
        if (selectedItem != null) {
          currentLayers.add(selectedItem);
          debugPrint('CharacterService: Adding visible layer: $groupName - ${selectedItem.flutterPath}');
        }
      }
    }
    
    debugPrint('CharacterService: getCurrentCharacterLayers returning ${currentLayers.length} layers');
    return currentLayers;
  }

  // Base body is always required and visible
  AssetMetadata? get baseBody {
    final baseLayer = _layers['base_body'];
    final result = baseLayer?.isVisible == true ? baseLayer?.selectedItem : null;
    debugPrint('CharacterService: baseBody getter - layer exists: ${baseLayer != null}, isVisible: ${baseLayer?.isVisible}, result: ${result?.flutterPath}');
    return result;
  }
} 