import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChartWidget extends StatelessWidget {
  const DonutChartWidget({super.key});

  static const _colors = [
    Color(0xFF4A90E2),   // 미정 - 파랑
    Color(0xFFFF8C42),   // 실행중 - 주황
    Color(0xFF7ED321),   // 실행중(경고) - 연두
    Color(0xFF417505),   // 중지됨 - 진녹
  ];

  static const _labels = ['미정', '실행 중', '실행 중 (경고)', '중지됨'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
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
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
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
              Text(_labels[i], style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
            ],
          )),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {},
          child: Text(
            '상세 보기',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
