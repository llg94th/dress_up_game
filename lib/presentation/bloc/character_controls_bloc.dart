import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/character_layer.dart';
import '../../core/services/character_service.dart';
import '../../core/services/sprite_cache_service.dart';
import 'character_controls_event.dart';
import 'character_controls_state.dart';

class CharacterControlsBloc extends Bloc<CharacterControlsEvent, CharacterControlsState> {
  Timer? _initCheckTimer;

  CharacterControlsBloc() : super(const CharacterControlsInitial()) {
    on<InitializeCharacterControlsEvent>(_onInitialize);
    on<CharacterInitializedEvent>(_onCharacterInitialized);
    on<LayerVisibilityToggleEvent>(_onLayerVisibilityToggle);
    on<SelectPreviousItemEvent>(_onSelectPreviousItem);
    on<SelectNextItemEvent>(_onSelectNextItem);
    on<ExportCharacterEvent>(_onExportCharacter);
  }

  final SpriteCacheService _spriteCacheService = SpriteCacheService.instance;
  final CharacterService _characterService = CharacterService.instance;

  @override
  Future<void> close() {
    _initCheckTimer?.cancel();
    return super.close();
  }

  Future<void> _onInitialize(
    InitializeCharacterControlsEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    await _spriteCacheService.preloadSprites();
    
    add(const CharacterInitializedEvent());
  }



  Future<void> _onCharacterInitialized(
    CharacterInitializedEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      final availableGroups = _characterService.availableGroups;
      final layers = <String, CharacterLayer>{};
      
      for (final groupName in availableGroups) {
        final layer = _characterService.getLayer(groupName);
        if (layer != null) {
          layers[groupName] = layer;
        }
      }

      emit(CharacterControlsLoaded(
        availableGroups: availableGroups,
        layers: layers,
      ));
    } catch (e) {
      emit(CharacterControlsError('Failed to load character data: $e'));
    }
  }

  Future<void> _onLayerVisibilityToggle(
    LayerVisibilityToggleEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! CharacterControlsLoaded && currentState is! CharacterControlsUpdated) return;

      final layer = _characterService.getLayer(event.groupName);
      if (layer == null) return;

      debugPrint('CharacterControlsBloc: Toggle visibility for ${event.groupName} (current: ${layer.isVisible})');

      if (layer.isVisible) {
        _characterService.hideLayer(event.groupName);
      } else {
        _characterService.showLayer(event.groupName);
      }

      // Get the updated layer after visibility change
      final updatedLayer = _characterService.getLayer(event.groupName);
      if (updatedLayer == null) return;

      debugPrint('CharacterControlsBloc: After toggle - new visibility: ${updatedLayer.isVisible}');

      // Get current layers map
      Map<String, CharacterLayer> currentLayers;
      List<String> availableGroups;
      
      if (currentState is CharacterControlsLoaded) {
        currentLayers = currentState.layers;
        availableGroups = currentState.availableGroups;
      } else {
        final updatedState = currentState as CharacterControlsUpdated;
        currentLayers = updatedState.layers;
        availableGroups = updatedState.availableGroups;
      }

      // Update the layers map
      final updatedLayers = Map<String, CharacterLayer>.from(currentLayers);
      updatedLayers[event.groupName] = updatedLayer;

      emit(CharacterControlsUpdated(
        availableGroups: availableGroups,
        layers: updatedLayers,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(CharacterControlsError('Failed to toggle layer visibility: $e'));
    }
  }

  Future<void> _onSelectPreviousItem(
    SelectPreviousItemEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! CharacterControlsLoaded && currentState is! CharacterControlsUpdated) return;

      final layer = _characterService.getLayer(event.groupName);
      if (layer == null || layer.items.isEmpty) return;

      debugPrint('CharacterControlsBloc: Previous clicked for ${event.groupName} (current index: ${layer.selectedIndex})');
      
      layer.selectPrevious();
      
      debugPrint('CharacterControlsBloc: After previous - new index: ${layer.selectedIndex}, visible: ${layer.isVisible}');

      // Update the layers map
      Map<String, CharacterLayer> updatedLayers;
      List<String> availableGroups;
      
      if (currentState is CharacterControlsLoaded) {
        updatedLayers = Map<String, CharacterLayer>.from(currentState.layers);
        availableGroups = currentState.availableGroups;
      } else {
        final updatedState = currentState as CharacterControlsUpdated;
        updatedLayers = Map<String, CharacterLayer>.from(updatedState.layers);
        availableGroups = updatedState.availableGroups;
      }
      
      updatedLayers[event.groupName] = layer;

      emit(CharacterControlsUpdated(
        availableGroups: availableGroups,
        layers: updatedLayers,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(CharacterControlsError('Failed to select previous item: $e'));
    }
  }

  Future<void> _onSelectNextItem(
    SelectNextItemEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! CharacterControlsLoaded && currentState is! CharacterControlsUpdated) return;

      final layer = _characterService.getLayer(event.groupName);
      if (layer == null || layer.items.isEmpty) return;

      debugPrint('CharacterControlsBloc: Next clicked for ${event.groupName} (current index: ${layer.selectedIndex})');
      
      layer.selectNext();
      
      debugPrint('CharacterControlsBloc: After next - new index: ${layer.selectedIndex}, visible: ${layer.isVisible}');

      // Update the layers map
      Map<String, CharacterLayer> updatedLayers;
      List<String> availableGroups;
      
      if (currentState is CharacterControlsLoaded) {
        updatedLayers = Map<String, CharacterLayer>.from(currentState.layers);
        availableGroups = currentState.availableGroups;
      } else {
        final updatedState = currentState as CharacterControlsUpdated;
        updatedLayers = Map<String, CharacterLayer>.from(updatedState.layers);
        availableGroups = updatedState.availableGroups;
      }
      
      updatedLayers[event.groupName] = layer;

      emit(CharacterControlsUpdated(
        availableGroups: availableGroups,
        layers: updatedLayers,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(CharacterControlsError('Failed to select next item: $e'));
    }
  }

  Future<void> _onExportCharacter(
    ExportCharacterEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      emit(const CharacterExporting());
      
      // TODO: Implement actual export functionality
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const CharacterExported());
    } catch (e) {
      emit(CharacterExportError('Failed to export character: $e'));
    }
  }
} 