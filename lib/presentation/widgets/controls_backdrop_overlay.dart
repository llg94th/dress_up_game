import 'package:flutter/material.dart';
import '../../core/game/dress_up_game.dart';

class ControlsBackdropOverlay extends StatelessWidget {
  final DressUpGame game;
  final ValueNotifier<bool> visibilityNotifier;

  const ControlsBackdropOverlay({
    super.key,
    required this.game,
    required this.visibilityNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          visibilityNotifier.value = false;
          game.overlays.remove('CharacterControls');
          game.overlays.remove('ControlsBackdrop');
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
} 