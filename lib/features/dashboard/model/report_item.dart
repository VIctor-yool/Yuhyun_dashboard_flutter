/// 자동 리포트 항목
class ReportItem {
  final String title;
  final String period;
  final String generateDate;
  final DateTime startDate;
  final DateTime endDate;

  const ReportItem({
    required this.title,
    required this.period,
    required this.generateDate,
    required this.startDate,
    required this.endDate,
  });
}
