import 'package:flutter/material.dart';
import '../../core/game/dress_up_game.dart';

class ControlsToggleOverlay extends StatefulWidget {
  final DressUpGame game;
  final ValueNotifier<bool> visibilityNotifier;

  const ControlsToggleOverlay({
    super.key,
    required this.game,
    required this.visibilityNotifier,
  });

  @override
  State<ControlsToggleOverlay> createState() => _ControlsToggleOverlayState();
}

class _ControlsToggleOverlayState extends State<ControlsToggleOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Listen to visibility changes from other sources
    widget.visibilityNotifier.addListener(_onVisibilityChanged);
  }

  @override
  void dispose() {
    widget.visibilityNotifier.removeListener(_onVisibilityChanged);
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged() {
    if (widget.visibilityNotifier.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _toggleControls() {
    final newVisibility = !widget.visibilityNotifier.value;
    widget.visibilityNotifier.value = newVisibility;

    if (newVisibility) {
      widget.game.overlays.add('ControlsBackdrop');
      widget.game.overlays.add('CharacterControls');
    } else {
      widget.game.overlays.remove('CharacterControls');
      widget.game.overlays.remove('ControlsBackdrop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Colors.pink, Colors.pinkAccent],
            ),
          ),
          child: IconButton(
            onPressed: _toggleControls,
            icon: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 3.14159, // 180 degrees
                  child: const Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            tooltip: widget.visibilityNotifier.value ? 'Hide Controls' : 'Show Controls',
          ),
        ),
      ),
    );
  }
} 