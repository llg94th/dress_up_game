import 'package:flutter/material.dart';
import 'asset_metadata.dart';

class CharacterLayer {
  final String groupName;
  final List<AssetMetadata> items;
  int selectedIndex;

  CharacterLayer({
    required this.groupName,
    required this.items,
    this.selectedIndex = 0,
  });

  AssetMetadata? get selectedItem => 
      items.isNotEmpty && selectedIndex >= 0 && selectedIndex < items.length
          ? items[selectedIndex]
          : null;

  bool get isVisible => selectedIndex >= 0;

  void selectNext() {
    if (items.isEmpty) return;
    
    final oldIndex = selectedIndex;
    
    // If hidden (-1), show first item (0)
    if (selectedIndex < 0) {
      selectedIndex = 0;
    } else {
      // Move to next item, or hide if at last item
      selectedIndex++;
      if (selectedIndex >= items.length) {
        selectedIndex = 0; 
      }
    }
    
    debugPrint('CharacterLayer ($groupName): selectNext - $oldIndex → $selectedIndex (visible: $isVisible)');
  }

  void selectPrevious() {
    if (items.isEmpty) return;
    
    final oldIndex = selectedIndex;
    
    // If hidden (-1), show last item
    if (selectedIndex < 0) {
      selectedIndex = items.length - 1;
    } else {
      // Move to previous item, or hide if at first item
      selectedIndex--;
      if (selectedIndex < 0) {
        selectedIndex = items.length - 1;
      }
    }
    
    debugPrint('CharacterLayer ($groupName): selectPrevious - $oldIndex → $selectedIndex (visible: $isVisible)');
  }

  void selectIndex(int index) {
    if (index >= -1 && index < items.length) {
      final oldIndex = selectedIndex;
      selectedIndex = index;
      debugPrint('CharacterLayer ($groupName): selectIndex - $oldIndex → $selectedIndex (visible: $isVisible)');
    }
  }

  void hide() {
    final oldIndex = selectedIndex;
    selectedIndex = -1;
    debugPrint('CharacterLayer ($groupName): hide - $oldIndex → $selectedIndex (visible: $isVisible)');
  }

  void show() {
    if (items.isNotEmpty && selectedIndex < 0) {
      final oldIndex = selectedIndex;
      selectedIndex = 0;
      debugPrint('CharacterLayer ($groupName): show - $oldIndex → $selectedIndex (visible: $isVisible)');
    }
  }

  String get displayName {
    if (!isVisible) {
      return 'Hidden';
    }
    return selectedItem?.itemName ?? '';
  }

  String get displayStatus {
    if (!isVisible) {
      return 'Hidden';
    }
    return '${selectedIndex + 1} / ${items.length}';
  }
} 