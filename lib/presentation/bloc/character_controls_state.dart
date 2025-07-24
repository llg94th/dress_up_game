import 'package:equatable/equatable.dart';
import '../../core/models/character_layer.dart';

abstract class CharacterControlsState extends Equatable {
  const CharacterControlsState();

  @override
  List<Object?> get props => [];
}

class CharacterControlsInitial extends CharacterControlsState {
  const CharacterControlsInitial();
}



class CharacterControlsLoaded extends CharacterControlsState {
  final List<String> availableGroups;
  final Map<String, CharacterLayer> layers;

  const CharacterControlsLoaded({
    required this.availableGroups,
    required this.layers,
  });

  @override
  List<Object?> get props => [availableGroups, layers];

  CharacterControlsLoaded copyWith({
    List<String>? availableGroups,
    Map<String, CharacterLayer>? layers,
  }) {
    return CharacterControlsLoaded(
      availableGroups: availableGroups ?? this.availableGroups,
      layers: layers ?? this.layers,
    );
  }
}

class CharacterControlsUpdated extends CharacterControlsState {
  final List<String> availableGroups;
  final Map<String, CharacterLayer> layers;
  final DateTime timestamp;

  const CharacterControlsUpdated({
    required this.availableGroups,
    required this.layers,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [availableGroups, layers, timestamp];
}

class CharacterControlsError extends CharacterControlsState {
  final String message;

  const CharacterControlsError(this.message);

  @override
  List<Object?> get props => [message];
}

class CharacterExporting extends CharacterControlsState {
  const CharacterExporting();
}

class CharacterExported extends CharacterControlsState {
  final String? filePath;

  const CharacterExported({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class CharacterExportError extends CharacterControlsState {
  final String message;

  const CharacterExportError(this.message);

  @override
  List<Object?> get props => [message];
} 