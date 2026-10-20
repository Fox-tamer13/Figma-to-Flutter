import 'package:flutter/material.dart';

class ScareLevelDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;

  const ScareLevelDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      
      initialSelection: selectedValue,
      expandedInsets: EdgeInsets.zero,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      
      textStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      
      dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
      
      onSelected: (String? newValue) {
        
      },
    );
  }
}
