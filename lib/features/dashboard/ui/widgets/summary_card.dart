import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: AppDesignSystem.spacingMd),
      padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeXs,
                    color: AppDesignSystem.textSecondary,
                    fontWeight: AppDesignSystem.fontWeightNormal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null)
                Icon(icon, size: 18, color: AppDesignSystem.textPlaceholder),
            ],
          ),
          const SizedBox(height: AppDesignSystem.spacingSm),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppDesignSystem.fontSizeTitle,
              fontWeight: AppDesignSystem.fontWeightBold,
              color: AppDesignSystem.textTitle,
            ),
          ),
        ],
      ),
    );
  }
}
