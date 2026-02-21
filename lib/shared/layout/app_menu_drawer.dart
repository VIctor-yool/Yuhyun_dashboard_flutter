import 'package:flutter/material.dart';

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
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'N',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '메뉴',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...AppMenuItem.values.map((item) {
          final isSelected = selectedItem == item;
          return ListTile(
            leading: Icon(
              item.icon,
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(
              item.label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
            selected: isSelected,
            selectedTileColor: Colors.grey.shade200,
            onTap: () => onItemSelected(item),
          );
        }),
      ],
    );
  }
}
