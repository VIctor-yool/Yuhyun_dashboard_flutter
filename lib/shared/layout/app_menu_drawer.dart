import 'package:flutter/material.dart';
import '../../core/theme/app_design_system.dart';

enum AppMenuItem {
  integratedDashboard('통합 대시보드', Icons.home),
  realtimeMonitoring('실시간 모니터링', Icons.bar_chart),
  alerts('알림', Icons.notifications),
  qrLookup('QR 조회', Icons.qr_code),
  autoReport('자동 리포트', Icons.description);

  final String label;
  final IconData icon;

  const AppMenuItem(this.label, this.icon);
}

class AppMenuDrawer extends StatelessWidget {
  final AppMenuItem selectedItem;
  final ValueChanged<AppMenuItem> onItemSelected;

  const AppMenuDrawer({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
          decoration: const BoxDecoration(color: AppDesignSystem.sidebarBg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppDesignSystem.slate700,
                  borderRadius: AppDesignSystem.borderRadiusLg,
                ),
                child: const Center(
                  child: Text(
                    '유',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDesignSystem.fontSizeTitle,
                      fontWeight: AppDesignSystem.fontWeightBold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDesignSystem.spacingMd),
              const Text(
                '유현건설',
                style: TextStyle(
                  color: AppDesignSystem.textTitle,
                  fontSize: AppDesignSystem.fontSizeSm,
                  fontWeight: AppDesignSystem.fontWeightBold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDesignSystem.spacingSm),
          child: Column(
            children: AppMenuItem.values.map((item) {
              final isSelected = selectedItem == item;
              return ListTile(
                leading: Icon(
                  item.icon,
                  size: 20,
                  color: isSelected ? AppDesignSystem.blue600 : AppDesignSystem.textSecondary,
                ),
                title: Text(
                  item.label,
                  style: TextStyle(
                    fontWeight: isSelected ? AppDesignSystem.fontWeightBold : AppDesignSystem.fontWeightNormal,
                    color: isSelected ? AppDesignSystem.blue600 : AppDesignSystem.textBody,
                    fontSize: AppDesignSystem.fontSizeSm,
                  ),
                ),
                selected: isSelected,
                selectedTileColor: AppDesignSystem.selectedBg,
                onTap: () => onItemSelected(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
