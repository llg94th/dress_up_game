import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../../core/game/dress_up_game.dart';
import 'character_controls_overlay.dart';
import 'controls_backdrop_overlay.dart';
import 'controls_toggle_overlay.dart';
import 'fullscreen_toggle_overlay.dart';
import 'loading_overlay.dart';
import 'dart:async';

class DressUpGameWidget extends StatefulWidget {
  final DressUpGame game;

  const DressUpGameWidget({super.key, required this.game});

  @override
  State<DressUpGameWidget> createState() => _DressUpGameWidgetState();
}

class _DressUpGameWidgetState extends State<DressUpGameWidget> {
  final ValueNotifier<bool> _controlsVisibilityNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Add loading overlay by default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.game.overlays.add('Loading');
    });
    
    // Listen to game initialization to remove loading overlay
    _checkGameInitialization();
  }

  void _checkGameInitialization() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (widget.game.isInitialized) {
        timer.cancel();
        // Remove loading overlay and add toggle buttons
        widget.game.overlays.remove('Loading');
        widget.game.overlays.add('ControlsToggle');
        widget.game.overlays.add('FullscreenToggle');
      }
    });
  }

  @override
  void dispose() {
    _controlsVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GameWidget<DressUpGame>.controlled(
              gameFactory: () => widget.game,
              overlayBuilderMap: {
                'Loading': (context, game) => LoadingOverlay(game: game),
                'ControlsToggle': (context, game) => ControlsToggleOverlay(
                  game: game,
                  visibilityNotifier: _controlsVisibilityNotifier,
                ),
                'FullscreenToggle': (context, game) => FullscreenToggleOverlay(
                  game: game,
                ),
                'ControlsBackdrop': (context, game) => ControlsBackdropOverlay(
                  game: game,
                  visibilityNotifier: _controlsVisibilityNotifier,
                ),
                'CharacterControls': (context, game) => CharacterControlsOverlay(
                  game: game,
                  visibilityNotifier: _controlsVisibilityNotifier,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
} 