import 'package:flutter/material.dart';
import '../../core/game/dress_up_game.dart';
import 'character_controls.dart';

class CharacterControlsOverlay extends StatelessWidget {
  final DressUpGame game;
  final ValueNotifier<bool> visibilityNotifier;

  const CharacterControlsOverlay({
    super.key,
    required this.game,
    required this.visibilityNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 0.35,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(-2, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: Column(
            children: [
              // Header with close button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.pinkAccent],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.palette,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Customize',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        visibilityNotifier.value = false;
                        game.overlays.remove('CharacterControls');
                        game.overlays.remove('ControlsBackdrop');
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),
              
              // Controls content
              Expanded(
                child: CharacterControls(
                  game: game,
                  onCharacterUpdated: () {
                    game.updateCharacter();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 