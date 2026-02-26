import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';
import 'widgets/traffic_line_chart.dart';
import 'widgets/usage_line_chart.dart';

/// 실시간 모니터링 — 계측 데이터 실시간 확인
class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSensorStatus(),
          const SizedBox(height: AppDesignSystem.spacingXl),
          _buildSection('실시간 계측 데이터 (트래픽)', const TrafficLineChart()),
          const SizedBox(height: AppDesignSystem.spacingXl),
          _buildSection('실시간 계측 데이터 (사용량)', const UsageLineChart()),
        ],
      ),
    );
  }

  Widget _buildSensorStatus() {
    return Container(
      padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '센서 상태',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              fontWeight: AppDesignSystem.fontWeightSemibold,
              color: AppDesignSystem.textTitle,
            ),
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          Row(
            children: [
              _buildStatusChip('정상', AppDesignSystem.emerald600, AppDesignSystem.emeraldBg),
              const SizedBox(width: AppDesignSystem.spacingSm),
              _buildStatusChip('경고', AppDesignSystem.amber600, AppDesignSystem.amberBg),
              const SizedBox(width: AppDesignSystem.spacingSm),
              _buildStatusChip('오류', AppDesignSystem.red600, AppDesignSystem.amberBg),
            ],
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          const Text(
            '연결된 센서: 12개 | 정상: 10 | 경고: 1 | 오류: 1',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeXs,
              color: AppDesignSystem.textCaption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignSystem.spacingMd,
        vertical: AppDesignSystem.spacingXs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDesignSystem.borderRadiusLg,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppDesignSystem.fontSizeXs,
          fontWeight: AppDesignSystem.fontWeightMedium,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget chart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppDesignSystem.fontSizeSm,
            fontWeight: AppDesignSystem.fontWeightSemibold,
            color: AppDesignSystem.textTitle,
          ),
        ),
        const SizedBox(height: AppDesignSystem.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
          decoration: BoxDecoration(
            color: AppDesignSystem.cardBg,
            borderRadius: AppDesignSystem.borderRadiusLg,
            border: Border.all(color: AppDesignSystem.borderDefault),
          ),
          child: chart,
        ),
      ],
    );
  }
}
