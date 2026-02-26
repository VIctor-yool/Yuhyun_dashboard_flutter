import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

/// 알림 — 계측 알림 목록 (임계값 초과 등)
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _filter = 'all'; // all, warning, error

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterBar(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
            children: _buildAlertList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignSystem.spacingLg,
        vertical: AppDesignSystem.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        border: Border(
          bottom: BorderSide(color: AppDesignSystem.borderLight),
        ),
      ),
      child: Row(
        children: [
          _buildFilterChip('전체', 'all'),
          const SizedBox(width: AppDesignSystem.spacingSm),
          _buildFilterChip('경고', 'warning'),
          const SizedBox(width: AppDesignSystem.spacingSm),
          _buildFilterChip('오류', 'error'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
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

  List<Widget> _buildAlertList() {
    final alerts = [
      _AlertItem('센서 A-01 임계값 초과', '경고', AppDesignSystem.amber600, '2분 전'),
      _AlertItem('센서 B-03 연결 끊김', '오류', AppDesignSystem.red600, '15분 전'),
      _AlertItem('센서 C-02 정상 복귀', '정상', AppDesignSystem.emerald600, '1시간 전'),
      _AlertItem('센서 A-02 임계값 근접', '경고', AppDesignSystem.amber600, '2시간 전'),
    ];

    return alerts
        .where((a) => _filter == 'all' || (_filter == 'warning' && a.type == '경고') || (_filter == 'error' && a.type == '오류'))
        .map((a) => _buildAlertCard(a))
        .toList();
  }

  Widget _buildAlertCard(_AlertItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDesignSystem.spacingMd),
      padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppDesignSystem.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeSm,
                    fontWeight: AppDesignSystem.fontWeightMedium,
                    color: AppDesignSystem.textTitle,
                  ),
                ),
                const SizedBox(height: AppDesignSystem.spacingXs),
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeXs,
                    color: AppDesignSystem.textCaption,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignSystem.spacingSm,
              vertical: AppDesignSystem.spacingXs,
            ),
            decoration: BoxDecoration(
              color: item.type == '경고'
                  ? AppDesignSystem.amberBg
                  : item.type == '오류'
                      ? AppDesignSystem.redBg
                      : AppDesignSystem.emeraldBg,
              borderRadius: AppDesignSystem.borderRadiusLg,
            ),
            child: Text(
              item.type,
              style: TextStyle(
                fontSize: AppDesignSystem.fontSizeXs,
                fontWeight: AppDesignSystem.fontWeightMedium,
                color: item.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertItem {
  final String title;
  final String type;
  final Color color;
  final String time;

  _AlertItem(this.title, this.type, this.color, this.time);
}
