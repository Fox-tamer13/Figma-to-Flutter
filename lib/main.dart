import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';
import 'view_models/attractions_view_model.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final viewModel = AttractionsViewModel();
  await viewModel.loadAttractions();
  debugPrint('👻 Loaded ${viewModel.attractions.length} spoopy spoops');
  for (final attraction in viewModel.attractions) {
    debugPrint('  • $attraction');
  }
  if (viewModel.errorMessage != null) {
    debugPrint('❌ ${viewModel.errorMessage}');
  }

  runApp(const SpoopyFinder());
}

class SpoopyFinder extends StatelessWidget {
  const SpoopyFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spoopy Finder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
