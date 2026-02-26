import 'package:flutter/material.dart';
import '../../core/theme/app_design_system.dart';

/// 재사용 가능한 필터 칩 (알림, 리포트 등)
class AppFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignSystem.spacingMd,
          vertical: AppDesignSystem.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppDesignSystem.selectedBg : AppDesignSystem.hoverBg,
          borderRadius: AppDesignSystem.borderRadiusLg,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppDesignSystem.fontSizeSm,
            fontWeight: AppDesignSystem.fontWeightMedium,
            color: isSelected ? AppDesignSystem.textTitle : AppDesignSystem.textSecondary,
          ),
        ),
      ),
    );
  }
}
