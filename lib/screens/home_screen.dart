import 'package:flutter/material.dart';
import 'package:spoopy_finder/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../view_models/attractions_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List is in order of Spoop to SPOOOOOOK (least to most)
  final List<String> _scareLevels = const [
    'Mildly Haunted',
    'Zombies Ahead',
    'Village of Shadows',
  ];
  final AttractionsViewModel _viewModel = AttractionsViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadAttractions();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppHeader(title: 'Spoopy Finder'),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          final visible = _viewModel.visibleAttractions;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                ScareLevelDropdown(
                  selectedValue: _scareLevels[_viewModel.maxScareLevel - 1],
                  items: _scareLevels,
                  onChanged: (String label) {
                    _viewModel.setMaxScareLevel(_scareLevels.indexOf(label) + 1);
                  },
                ),
                const SizedBox(height: 16),
                if (_viewModel.isLoading)
                  const LinearProgressIndicator()
                else if (_viewModel.errorMessage != null)
                  Text(
                    _viewModel.errorMessage!,
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                  )
                else
                  Text(
                    'Showing ${visible.length} of ${_viewModel.attractions.length} haunts',
                    style: textTheme.bodyMedium,
                  ),
                const SizedBox(height: 16),
                SpoopyMap(attractions: visible),
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
          );
        }
      ),
    );
  }
}