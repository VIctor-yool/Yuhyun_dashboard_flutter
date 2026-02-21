/// 대시보드 KPI 요약 모델
class DashboardSummary {
  final String dailyTraffic;
  final String dailyUsage;
  final String recent30DaySubscriptions;
  final String deployedApps;

  const DashboardSummary({
    required this.dailyTraffic,
    required this.dailyUsage,
    required this.recent30DaySubscriptions,
    required this.deployedApps,
  });

  factory DashboardSummary.empty() => const DashboardSummary(
        dailyTraffic: '0',
        dailyUsage: '0',
        recent30DaySubscriptions: '2',
        deployedApps: '3',
      );
}
