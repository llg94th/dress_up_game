import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../../core/game/dress_up_game.dart';

class FullscreenToggleOverlay extends StatefulWidget {
  final DressUpGame game;

  const FullscreenToggleOverlay({
    super.key,
    required this.game,
  });

  @override
  State<FullscreenToggleOverlay> createState() => _FullscreenToggleOverlayState();
}

class _FullscreenToggleOverlayState extends State<FullscreenToggleOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFullscreen() async {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    if (_isFullscreen) {
      _animationController.forward();
      if (kIsWeb) {
        // For web, we'll handle this differently
        // For now, just show a message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press F11 for fullscreen on web'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        // For mobile/desktop
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
        );
      }
    } else {
      _animationController.reverse();
      if (!kIsWeb) {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 80, // Positioned to the left of controls toggle (which is at right: 20)
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: _isFullscreen 
                  ? [Colors.orange, Colors.deepOrange]
                  : [Colors.grey.shade600, Colors.grey.shade700],
            ),
          ),
          child: IconButton(
            onPressed: _toggleFullscreen,
            icon: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_animationController.value * 0.1),
                  child: Icon(
                    _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            tooltip: _isFullscreen ? 'Exit Fullscreen' : 'Enter Fullscreen',
          ),
        ),
      ),
    );
  }
} 