import 'package:flutter/material.dart';
import 'package:spoopy_finder/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

    final List<String> _scareLevels = const [
    'Mildly Haunted',
    'Zombies Ahead',
    'Village of Shadows',
  ];

  @override
  Widget build(BuildContext context) {
    const selectedLevel = 'Mildly Haunted';
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppHeader(title: 'Spoopy Finder'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            ScareLevelDropdown(
              selectedValue: selectedLevel,
              items: _scareLevels,
            ),
            const SizedBox(height: 40),
            const SpoopyMap(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/home/camera_icon2.svg',
                    colorFilter: ColorFilter.mode(
                      colorScheme.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/home/photo_icon2.svg',
                    colorFilter: ColorFilter.mode(
                      colorScheme.secondary,
                      BlendMode.srcIn,
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
