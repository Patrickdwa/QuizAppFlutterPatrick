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
    // Gunakan GestureDetector untuk menangani onTap pada seluruh area
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Lebar penuh
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: const EdgeInsets.only(bottom: 12.0), // Jarak antar opsi
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200], // Logika warna
          borderRadius: BorderRadius.circular(12.0), // Sudut membulat
        ),
        child: Text(
          optionText,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87, // Logika warna teks
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}