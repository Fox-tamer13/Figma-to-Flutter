import 'package:flutter/material.dart';
import 'package:spoopy_finder/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> _scareLevels = const[
    'Mildly Haunted',
    'Zombos Ahead',
    'Village of Shadows',
  ];

  @override
  Widget build(BuildContext context) {
    const selectedLevel = 'Mildly Haunted';

    return Scaffold(
      appBar: const AppHeader(
        title: 'Spoopy Finder',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            ScareLevelDropdown(
              selectedValue: selectedLevel,
              items: _scareLevels,
            ),
            const SizedBox(height: 24),
            const MapPlaceholder(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.photo_library),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}