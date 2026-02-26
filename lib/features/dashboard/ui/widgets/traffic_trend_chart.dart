import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

class TrafficTrendChart extends StatelessWidget {
  const TrafficTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDesignSystem.chartHeight,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 5,
              minY: 0,
              maxY: 7,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (_) => const FlLine(
                  color: AppDesignSystem.chartGrid,
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: AppDesignSystem.chartAxis,
                        fontSize: AppDesignSystem.fontSizeXs,
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    getTitlesWidget: (value, meta) {
                      const labels = ['5/21', '5/28', '6/4', '6/11', '6/18', '6/20'];
                      final idx = value.toInt().clamp(0, 5);
                      return Padding(
                        padding: const EdgeInsets.only(top: AppDesignSystem.spacingSm),
                        child: Text(
                          labels[idx],
                          style: const TextStyle(
                            color: AppDesignSystem.chartAxis,
                            fontSize: AppDesignSystem.fontSizeXs,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 0),
                    FlSpot(1, 2),
                    FlSpot(2, 1.5),
                    FlSpot(3, 5),
                    FlSpot(4, 3),
                    FlSpot(5, 4),
                  ],
                  isCurved: true,
                  color: AppDesignSystem.chartLineBlue,
                  barWidth: 2.5,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: AppDesignSystem.chartLineBlue,
                      strokeWidth: 1,
                      strokeColor: Colors.white,
                    ),
                  ),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDesignSystem.spacingSm),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppDesignSystem.chartLineBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              '트래픽',
              style: TextStyle(
                fontSize: AppDesignSystem.fontSizeXs,
                color: AppDesignSystem.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
