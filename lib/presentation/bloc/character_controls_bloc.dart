import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/game/dress_up_game.dart';
import '../../core/models/character_layer.dart';
import 'character_controls_event.dart';
import 'character_controls_state.dart';

class CharacterControlsBloc extends Bloc<CharacterControlsEvent, CharacterControlsState> {
  final DressUpGame game;
  Timer? _initCheckTimer;

  CharacterControlsBloc({required this.game}) : super(const CharacterControlsInitial()) {
    on<InitializeCharacterControlsEvent>(_onInitialize);
    on<CharacterInitializedEvent>(_onCharacterInitialized);
    on<LayerVisibilityToggleEvent>(_onLayerVisibilityToggle);
    on<SelectPreviousItemEvent>(_onSelectPreviousItem);
    on<SelectNextItemEvent>(_onSelectNextItem);
    on<ExportCharacterEvent>(_onExportCharacter);
  }

  @override
  Future<void> close() {
    _initCheckTimer?.cancel();
    return super.close();
  }

  Future<void> _onInitialize(
    InitializeCharacterControlsEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    if (!game.isInitialized) {
      // Wait for game to be initialized
      while (!game.isInitialized) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    
    // Game is initialized, load character data
    add(const CharacterInitializedEvent());
  }



  Future<void> _onCharacterInitialized(
    CharacterInitializedEvent event,
    Emitter<CharacterControlsState> emit,
  ) async {
    try {
      final availableGroups = game.characterService.availableGroups;
      final layers = <String, CharacterLayer>{};
      
      for (final groupName in availableGroups) {
        final layer = game.characterService.getLayer(groupName);
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

      final layer = game.characterService.getLayer(event.groupName);
      if (layer == null) return;

      debugPrint('CharacterControlsBloc: Toggle visibility for ${event.groupName} (current: ${layer.isVisible})');

      if (layer.isVisible) {
        game.characterService.hideLayer(event.groupName);
      } else {
        game.characterService.showLayer(event.groupName);
      }

      // Get the updated layer after visibility change
      final updatedLayer = game.characterService.getLayer(event.groupName);
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

      final layer = game.characterService.getLayer(event.groupName);
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

      final layer = game.characterService.getLayer(event.groupName);
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