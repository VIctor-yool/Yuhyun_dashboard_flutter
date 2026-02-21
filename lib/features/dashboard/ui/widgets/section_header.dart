import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onRefresh;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
            onTap: onRefresh,
            child: Text(
              '새로고침',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}
