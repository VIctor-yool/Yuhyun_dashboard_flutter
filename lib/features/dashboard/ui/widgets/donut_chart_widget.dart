import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

class DonutChartWidget extends StatelessWidget {
  const DonutChartWidget({super.key});

  static const _colors = [
    AppDesignSystem.pieUndefined,
    AppDesignSystem.pieRunning,
    AppDesignSystem.pieWarning,
    AppDesignSystem.pieStopped,
  ];

  static const _labels = ['미정', '실행 중', '실행 중 (경고)', '중지됨'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDesignSystem.chartHeight,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 50,
              sectionsSpace: 1,
              sections: [
                PieChartSectionData(
                  value: 25,
                  title: '',
                  color: _colors[0],
                  radius: 45,
                  titleStyle: const TextStyle(fontSize: 0),
                ),
                PieChartSectionData(
                  value: 35,
                  title: '',
                  color: _colors[1],
                  radius: 45,
                  titleStyle: const TextStyle(fontSize: 0),
                ),
                PieChartSectionData(
                  value: 20,
                  title: '',
                  color: _colors[2],
                  radius: 45,
                  titleStyle: const TextStyle(fontSize: 0),
                ),
                PieChartSectionData(
                  value: 20,
                  title: '',
                  color: _colors[3],
                  radius: 45,
                  titleStyle: const TextStyle(fontSize: 0),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDesignSystem.spacingMd),
        Wrap(
          spacing: AppDesignSystem.spacingMd,
          runSpacing: AppDesignSystem.spacingSm,
          children: List.generate(4, (i) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _colors[i],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _labels[i],
                style: const TextStyle(
                  fontSize: AppDesignSystem.fontSizeXs,
                  color: AppDesignSystem.textSecondary,
                ),
              ),
            ],
          )),
        ),
        const SizedBox(height: AppDesignSystem.spacingMd),
        GestureDetector(
          onTap: () {},
          child: const Text(
            '상세 보기',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              color: AppDesignSystem.blue600,
              fontWeight: AppDesignSystem.fontWeightMedium,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
