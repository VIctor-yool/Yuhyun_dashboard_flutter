import '../model/dashboard_summary.dart';

/// 대시보드 데이터 레포지토리 (추후 API 연동용)
class DashboardRepository {
  Future<DashboardSummary> getSummary() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return DashboardSummary.empty();
  }
}
