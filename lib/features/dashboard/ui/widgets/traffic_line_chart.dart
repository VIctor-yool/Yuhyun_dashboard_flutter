import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrafficLineChart extends StatelessWidget {
  const TrafficLineChart({super.key});

  static const _trafficColor = Color(0xFFFF8C42);

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
              maxY: 7,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade200,
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
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
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
                    FlSpot(1, 1),
                    FlSpot(2, 0.5),
                    FlSpot(3, 6),
                    FlSpot(4, 4),
                    FlSpot(5, 5),
                  ],
                  isCurved: true,
                  color: _trafficColor,
                  barWidth: 2.5,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: _trafficColor,
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
                color: _trafficColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text('트래픽', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          ],
        ),
      ],
    );
  }
}
