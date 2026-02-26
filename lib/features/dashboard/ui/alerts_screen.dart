import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../shared/widgets/filter_chip.dart';
import '../model/alert_item.dart';

/// 알림 — 계측 알림 목록 (임계값 초과 등)
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _filter = 'all';

  static const _alerts = [
    AlertItem(
      title: '센서 A-01 임계값 초과',
      type: '경고',
      color: AppDesignSystem.amber600,
      time: '2분 전',
    ),
    AlertItem(
      title: '센서 B-03 연결 끊김',
      type: '오류',
      color: AppDesignSystem.red600,
      time: '15분 전',
    ),
    AlertItem(
      title: '센서 C-02 정상 복귀',
      type: '정상',
      color: AppDesignSystem.emerald600,
      time: '1시간 전',
    ),
    AlertItem(
      title: '센서 A-02 임계값 근접',
      type: '경고',
      color: AppDesignSystem.amber600,
      time: '2시간 전',
    ),
  ];

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
        border: Border(bottom: BorderSide(color: AppDesignSystem.borderLight)),
      ),
      child: Row(
        children: [
          AppFilterChip(label: '전체', isSelected: _filter == 'all', onTap: () => setState(() => _filter = 'all')),
          const SizedBox(width: AppDesignSystem.spacingSm),
          AppFilterChip(label: '경고', isSelected: _filter == 'warning', onTap: () => setState(() => _filter = 'warning')),
          const SizedBox(width: AppDesignSystem.spacingSm),
          AppFilterChip(label: '오류', isSelected: _filter == 'error', onTap: () => setState(() => _filter = 'error')),
        ],
      ),
    );
  }

  List<Widget> _buildAlertList() {
    final filtered = _alerts.where((a) {
      if (_filter == 'all') return true;
      if (_filter == 'warning') return a.type == '경고';
      if (_filter == 'error') return a.type == '오류';
      return false;
    }).toList();

    return filtered.map((a) => _buildAlertCard(a)).toList();
  }

  Widget _buildAlertCard(AlertItem item) {
    final bgColor = item.type == '경고'
        ? AppDesignSystem.amberBg
        : item.type == '오류'
            ? AppDesignSystem.redBg
            : AppDesignSystem.emeraldBg;

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
              color: bgColor,
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
