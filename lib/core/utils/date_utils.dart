/// 날짜 포맷 유틸리티
class AppDateUtils {
  AppDateUtils._();

  /// YYYY.MM.DD 형식
  static String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  /// YYYY.MM.DD ~ YYYY.MM.DD 기간 형식
  static String formatDateRange(DateTime start, DateTime end) {
    return '${formatDate(start)} ~ ${formatDate(end)}';
  }

  /// 월의 주차 수 (1~7일=1주차, 8~14일=2주차, ...)
  static int weekOfMonth(DateTime date) {
    return ((date.day - 1) ~/ 7) + 1;
  }

  /// 해당 월의 총 주차 수
  static int weeksInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return ((lastDay - 1) ~/ 7) + 1;
  }

  /// 주차별 시작일·종료일 (해당 월 내)
  static (DateTime start, DateTime end) getWeekRange(int year, int month, int week) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final startDay = (1 + (week - 1) * 7).clamp(1, lastDay);
    final endDay = (startDay + 6).clamp(1, lastDay);
    return (
      DateTime(year, month, startDay),
      DateTime(year, month, endDay),
    );
  }
}
