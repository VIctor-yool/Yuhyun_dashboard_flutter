import 'package:flutter/material.dart';
import 'widgets/dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKpiCards(),
          const SizedBox(height: 28),
          _buildTrafficSection(),
          const SizedBox(height: 32),
          _buildUsageSection(),
          const SizedBox(height: 32),
          _buildTrafficTrendSection(),
          const SizedBox(height: 32),
          _buildMonitoringSection(),
        ],
      ),
    );
  }

  Widget _buildKpiCards() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SummaryCard(title: "당일 트래픽", value: "0", icon: Icons.trending_up),
          SummaryCard(title: "당일 사용량", value: "0", icon: Icons.storage),
          SummaryCard(title: "최근 30일 구독", value: "2", icon: Icons.people),
          SummaryCard(title: "배포된 앱", value: "3", icon: Icons.apps),
        ],
      ),
    );
  }

  Widget _buildTrafficSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "전체 앱 트래픽 발생량", onRefresh: () {}),
        const SizedBox(height: 12),
        const TrafficLineChart(),
      ],
    );
  }

  Widget _buildUsageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "전체 앱 사용량", onRefresh: () {}),
        const SizedBox(height: 12),
        const UsageLineChart(),
      ],
    );
  }

  Widget _buildTrafficTrendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "상위 5개 사용 앱 트래픽 추이 비교", onRefresh: () {}),
        const SizedBox(height: 12),
        const TrafficTrendChart(),
      ],
    );
  }

  Widget _buildMonitoringSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "운영 모니터링", onRefresh: () {}),
        const SizedBox(height: 12),
        const DonutChartWidget(),
      ],
    );
  }
}
