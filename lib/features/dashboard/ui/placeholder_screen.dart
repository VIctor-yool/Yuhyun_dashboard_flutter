import 'package:flutter/material.dart';

/// 메뉴 카테고리용 플레이스홀더 화면
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '준비 중입니다',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
    );
  }
}
