import 'package:equatable/equatable.dart';

abstract class CharacterControlsEvent extends Equatable {
  const CharacterControlsEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCharacterControlsEvent extends CharacterControlsEvent {
  const InitializeCharacterControlsEvent();
}

class UpdateLoadingProgressEvent extends CharacterControlsEvent {
  final double progress;

  const UpdateLoadingProgressEvent(this.progress);

  @override
  List<Object?> get props => [progress];
}

class CharacterInitializedEvent extends CharacterControlsEvent {
  const CharacterInitializedEvent();
}

class LayerVisibilityToggleEvent extends CharacterControlsEvent {
  final String groupName;

  const LayerVisibilityToggleEvent(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class SelectPreviousItemEvent extends CharacterControlsEvent {
  final String groupName;

  const SelectPreviousItemEvent(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class SelectNextItemEvent extends CharacterControlsEvent {
  final String groupName;

  const SelectNextItemEvent(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class ExportCharacterEvent extends CharacterControlsEvent {
  const ExportCharacterEvent();
} 