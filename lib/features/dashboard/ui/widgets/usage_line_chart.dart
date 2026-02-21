import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UsageLineChart extends StatelessWidget {
  const UsageLineChart({super.key});

  static const _usageColor = Color(0xFF4A90E2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 5,
              minY: 0,
              maxY: 0.0025,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (value, meta) => Text(
                      value.toStringAsFixed(4),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
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
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          labels[idx],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10,
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
                    FlSpot(1, 0.0005),
                    FlSpot(2, 0.001),
                    FlSpot(3, 0.0015),
                    FlSpot(4, 0.001),
                    FlSpot(5, 0.002),
                  ],
                  isCurved: true,
                  color: _usageColor,
                  barWidth: 2.5,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: _usageColor,
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
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _usageColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text('데이터 (MB)', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          ],
        ),
      ],
    );
  }
}
