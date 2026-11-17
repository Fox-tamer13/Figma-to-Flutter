import 'package:flutter/material.dart';
import '../data/maps_link_service.dart';
import '../models/attraction.dart';

class HauntDetailsSheet extends StatelessWidget {
  const HauntDetailsSheet({super.key, required this.attraction});

  final Attraction attraction;

  String _typeLabel(AttractionType type) {
    return switch (type) {
      AttractionType.hauntedHouse => 'Haunted House',
      AttractionType.pumpkinPatch => 'Pumpkin Patch',
      AttractionType.cornMaze => 'Corn Maze',
    };
  }

  Future<void> _openInMaps(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final bool opened = await MapsLinkService().open(attraction);

    if (!opened){
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text("Couldn't open a maps app."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attraction.name, style: textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              '${_typeLabel(attraction.type)} · Scare Level: ${attraction.scareLevel}',
              style: textTheme.titleSmall?.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(attraction.description, style: textTheme.bodyLarge),
            const SizedBox(width: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.place, size: 20, color: colorScheme.onSurface),
                const SizedBox(width: 8,),
                Expanded(
                  child: Text(attraction.address, style: textTheme.bodyMedium),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _openInMaps(context),
              icon: const Icon(Icons.directions),
              label: const Text('Open in Maps'),
            ),
          ],
        ),
      ),
    );
  }
}