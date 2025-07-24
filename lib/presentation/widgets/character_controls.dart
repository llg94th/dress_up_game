import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/game/dress_up_game.dart';
import '../../core/models/character_layer.dart';
import '../bloc/character_controls_bloc.dart';
import '../bloc/character_controls_event.dart';
import '../bloc/character_controls_state.dart';

class CharacterControls extends StatelessWidget {
  final DressUpGame game;
  final VoidCallback onCharacterUpdated;

  const CharacterControls({
    super.key,
    required this.game,
    required this.onCharacterUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterControlsBloc(game: game)
        ..add(const InitializeCharacterControlsEvent()),
      child: BlocListener<CharacterControlsBloc, CharacterControlsState>(
        listener: (context, state) {
          if (state is CharacterControlsUpdated) {
            onCharacterUpdated();
          } else if (state is CharacterControlsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is CharacterExported) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Character exported successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is CharacterExportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CharacterControlsBloc, CharacterControlsState>(
          builder: (context, state) {
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CharacterControlsState state) {
    if (state is CharacterControlsLoading) {
      return _buildLoadingView(state.progress);
    } else if (state is CharacterControlsLoaded || state is CharacterControlsUpdated) {
      List<String> availableGroups;
      Map<String, CharacterLayer> layers;
      
      if (state is CharacterControlsLoaded) {
        availableGroups = state.availableGroups;
        layers = state.layers;
      } else {
        final updatedState = state as CharacterControlsUpdated;
        availableGroups = updatedState.availableGroups;
        layers = updatedState.layers;
      }
      
      return _buildControlsView(context, availableGroups, layers, state is CharacterExporting);
    } else if (state is CharacterControlsError) {
      return _buildErrorView(context, state.message);
    } else if (state is CharacterExporting) {
      // Show loading overlay for exporting
      return _buildControlsView(context, [], {}, true);
    }
    
    return _buildLoadingView(0.0);
  }

  Widget _buildLoadingView(double progress) {
    final progressPercentage = (progress * 100).toInt();
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular progress indicator
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 4,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
              ),
            ),
            const SizedBox(height: 16),
            
            // Progress text
            const Text(
              'Loading Assets...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 6),
            
            // Progress percentage
            Text(
              '$progressPercentage%',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            
            // Progress bar
            Container(
              width: double.infinity,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.shade300,
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: const LinearGradient(
                      colors: [Colors.pink, Colors.pinkAccent],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Loading details
            Text(
              'Preloading sprites...',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsView(
    BuildContext context, 
    List<String> availableGroups, 
    Map<String, CharacterLayer> layers,
    bool isExporting,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: availableGroups.length,
              itemBuilder: (context, index) {
                final groupName = availableGroups[index];
                final layer = layers[groupName];
                
                if (layer == null) return const SizedBox.shrink();
                
                return _buildGroupControl(context, groupName, layer);
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              'Error Loading',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CharacterControlsBloc>()
                      .add(const InitializeCharacterControlsEvent());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Retry', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupControl(BuildContext context, String groupName, CharacterLayer layer) {
    final isBaseBody = groupName == 'base_body';
    final isCostume = groupName == 'costume';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _formatGroupName(groupName),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Hide/Show toggle button (except for base body)
                if (!isBaseBody)
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: () {
                        if (isCostume) {
                          _showVipFeatureDialog(context);
                          return;
                        }
                        context.read<CharacterControlsBloc>()
                            .add(LayerVisibilityToggleEvent(groupName));
                      },
                      icon: Icon(
                        layer.isVisible ? Icons.visibility : Icons.visibility_off,
                        color: layer.isVisible ? Colors.pink : Colors.grey,
                        size: 18,
                      ),
                      tooltip: layer.isVisible ? 'Hide layer' : 'Show layer',
                      padding: EdgeInsets.zero,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            // Layer selection controls (only show if visible or base body)
            if (layer.isVisible || isBaseBody) ...[
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: layer.items.isEmpty ? null : () {
                        context.read<CharacterControlsBloc>()
                            .add(SelectPreviousItemEvent(groupName));
                      },
                      icon: const Icon(Icons.chevron_left, size: 18),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.pink.shade50,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _formatItemName(layer.displayName),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: layer.items.isEmpty ? null : () {
                        context.read<CharacterControlsBloc>()
                            .add(SelectNextItemEvent(groupName));
                      },
                      icon: const Icon(Icons.chevron_right, size: 18),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.pink.shade50,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                layer.displayStatus,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              // Hidden state display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Layer Hidden',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatGroupName(String groupName) {
    return groupName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatItemName(String itemName) {
    return itemName
        .replaceAll('_png', '')
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}


Future<void> _showVipFeatureDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('VIP Feature'),
        content: const Text('This feature is only available for VIP members.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
