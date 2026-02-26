import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

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
          style: const TextStyle(
            fontSize: AppDesignSystem.fontSizeSm,
            fontWeight: AppDesignSystem.fontWeightSemibold,
            color: AppDesignSystem.textTitle,
          ),
        ),
        GestureDetector(
          onTap: onRefresh,
          child: const Text(
            '새로고침',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              color: AppDesignSystem.textSecondary,
              fontWeight: AppDesignSystem.fontWeightNormal,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
