import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue.shade100 : Colors.white,
      child: ListTile(
        title: Text(optionText),
        onTap: onTap,
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
      ),
    );
  }
}