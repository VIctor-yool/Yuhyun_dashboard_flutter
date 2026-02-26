import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';
import 'widgets/bootstrap_calendar_modal.dart';

/// 자동 리포트 — 자동 생성 리포트 목록
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  /// week, month, year: 기간 탭 선택 시 날짜 비활성화, 월/연 표시
  /// range: 기간 직접 선택 시 날짜 선택 활성화
  String _periodFilter = 'month';

  DateTime _rangeStart = DateTime(2024, 1, 1);
  DateTime _rangeEnd = DateTime(2024, 2, 29);

  int _selectedYear = 2024;
  int _selectedMonth = 1;
  int _selectedWeek = 1;

  int _weekOfMonth(DateTime d) => ((d.day - 1) ~/ 7) + 1;

  int get _weeksInMonth => ((DateTime(_selectedYear, _selectedMonth + 1, 0).day - 1) ~/ 7) + 1;

  bool get _isDatePickerEnabled => _periodFilter == 'range';

  void _initPeriodFromRange() {
    _selectedYear = _rangeStart.year;
    _selectedMonth = _rangeStart.month;
    _selectedWeek = _weekOfMonth(_rangeStart);
  }

  void _syncRangeFromPeriod() {
    switch (_periodFilter) {
      case 'week':
        final week = _selectedWeek.clamp(1, _weeksInMonth);
        final (start, end) = _getWeekRange(_selectedYear, _selectedMonth, week);
        _rangeStart = start;
        _rangeEnd = end;
        break;
      case 'month':
        _rangeStart = DateTime(_selectedYear, _selectedMonth, 1);
        _rangeEnd = DateTime(_selectedYear, _selectedMonth + 1, 0);
        break;
      case 'year':
        _rangeStart = DateTime(_selectedYear, 1, 1);
        _rangeEnd = DateTime(_selectedYear, 12, 31);
        break;
      default:
        break;
    }
  }

  (DateTime, DateTime) _getWeekRange(int year, int month, int week) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final startDay = 1 + (week - 1) * 7;
    final endDay = (startDay + 6).clamp(1, lastDay);
    final actualStartDay = startDay.clamp(1, lastDay);
    return (
      DateTime(year, month, actualStartDay),
      DateTime(year, month, endDay),
    );
  }

  Future<void> _showCalendarModal() async {
    if (!_isDatePickerEnabled) return;
    await showDialog(
      context: context,
      barrierColor: AppDesignSystem.overlayBg,
      builder: (context) => BootstrapCalendarModal(
        initialStart: _rangeStart,
        initialEnd: _rangeEnd,
        onRangeSelected: (start, end) {
          setState(() {
            _rangeStart = start;
            _rangeEnd = end;
          });
        },
      ),
    );
  }

  String _formatDateRange() {
    return '${_rangeStart.year}.${_rangeStart.month.toString().padLeft(2, '0')}.${_rangeStart.day.toString().padLeft(2, '0')} ~ '
        '${_rangeEnd.year}.${_rangeEnd.month.toString().padLeft(2, '0')}.${_rangeEnd.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterBar(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
            children: _buildReportList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignSystem.spacingLg,
        vertical: AppDesignSystem.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        border: Border(
          bottom: BorderSide(color: AppDesignSystem.borderLight),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterChip('주간', 'week'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildFilterChip('월간', 'month'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildFilterChip('연간', 'year'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildFilterChip('기간 선택', 'range'),
            const SizedBox(width: AppDesignSystem.spacingLg),
            SizedBox(
              width: 260,
              child: _buildDateInputGroup(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _periodFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _periodFilter = value;
          if (value != 'range') {
            _initPeriodFromRange();
            _syncRangeFromPeriod();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignSystem.spacingMd,
          vertical: AppDesignSystem.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppDesignSystem.selectedBg : AppDesignSystem.hoverBg,
          borderRadius: AppDesignSystem.borderRadiusLg,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppDesignSystem.fontSizeSm,
            fontWeight: AppDesignSystem.fontWeightMedium,
            color: isSelected ? AppDesignSystem.textTitle : AppDesignSystem.textSecondary,
          ),
        ),
      ),
    );
  }

  /// Bootstrap input-group 스타일: .input-group-addon + .input-group-text
  /// 캘린더 아이콘 왼쪽, 날짜/월·연 표시 오른쪽
  Widget _buildDateInputGroup() {
    const addonPadding = EdgeInsets.fromLTRB(9, 4, 9, 4);
    const iconSize = 18.0;

    return Container(
      decoration: BoxDecoration(
        color: AppDesignSystem.bgPrimary,
        border: Border.all(color: AppDesignSystem.borderDefault),
        borderRadius: AppDesignSystem.borderRadiusLg,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // .input-group-addon — 캘린더 아이콘 (border-left: 0, padding: 4px 9px)
          Container(
            padding: addonPadding,
            decoration: BoxDecoration(
              color: _isDatePickerEnabled ? AppDesignSystem.bgPrimary : AppDesignSystem.slate100,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppDesignSystem.radiusLg)),
            ),
            child: GestureDetector(
              onTap: _isDatePickerEnabled ? _showCalendarModal : null,
              child: Icon(
                Icons.calendar_month,
                size: iconSize,
                color: _isDatePickerEnabled ? AppDesignSystem.textSecondary : AppDesignSystem.textPlaceholder,
              ),
            ),
          ),
          // 날짜/월·연 표시 영역
          Expanded(
            child: _isDatePickerEnabled
                ? InkWell(
                    onTap: _showCalendarModal,
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(AppDesignSystem.radiusLg)),
                    child: Container(
                      padding: addonPadding,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(AppDesignSystem.radiusLg)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _formatDateRange(),
                              style: const TextStyle(
                                fontSize: AppDesignSystem.fontSizeSm,
                                color: AppDesignSystem.textTitle,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: AppDesignSystem.textSecondary, size: 20),
                        ],
                      ),
                    ),
                  )
                : _buildMonthYearSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthYearSelector() {
    const addonPadding = EdgeInsets.fromLTRB(9, 4, 9, 4);

    return Container(
      padding: addonPadding,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_periodFilter == 'year') ...[
              _buildDropdown<int>(
                value: _selectedYear,
                items: List.generate(10, (i) => DateTime.now().year - 5 + i),
                labelBuilder: (v) => '$v년',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedYear = v;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
            ] else if (_periodFilter == 'month') ...[
              _buildDropdown<int>(
                value: _selectedYear,
                items: List.generate(10, (i) => DateTime.now().year - 5 + i),
                labelBuilder: (v) => '$v년',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedYear = v;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
              const SizedBox(width: AppDesignSystem.spacingSm),
              _buildDropdown<int>(
                value: _selectedMonth,
                items: List.generate(12, (i) => i + 1),
                labelBuilder: (v) => '$v월',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedMonth = v;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
            ] else ...[
              // 주간 — 월 변경 시 주차 범위 재조정
              _buildDropdown<int>(
                value: _selectedYear,
                items: List.generate(10, (i) => DateTime.now().year - 5 + i),
                labelBuilder: (v) => '$v년',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedYear = v;
                      if (_selectedWeek > _weeksInMonth) _selectedWeek = _weeksInMonth;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
              const SizedBox(width: AppDesignSystem.spacingSm),
              _buildDropdown<int>(
                value: _selectedMonth,
                items: List.generate(12, (i) => i + 1),
                labelBuilder: (v) => '$v월',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedMonth = v;
                      if (_selectedWeek > _weeksInMonth) _selectedWeek = _weeksInMonth;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
              const SizedBox(width: AppDesignSystem.spacingSm),
              _buildDropdown<int>(
                value: _selectedWeek.clamp(1, _weeksInMonth),
                items: List.generate(_weeksInMonth, (i) => i + 1),
                labelBuilder: (v) => '$v주차',
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      _selectedWeek = v;
                      _syncRangeFromPeriod();
                    });
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required String Function(T) labelBuilder,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isDense: true,
        items: items.map((v) => DropdownMenuItem(value: v, child: Text(labelBuilder(v), style: const TextStyle(fontSize: AppDesignSystem.fontSizeSm)))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  List<Widget> _buildReportList() {
    final allReports = [
      _ReportItem('2024년 2월 계측 리포트', '2024.02.01 ~ 2024.02.29', '2024.03.01', DateTime(2024, 2, 1), DateTime(2024, 2, 29)),
      _ReportItem('2024년 1월 계측 리포트', '2024.01.01 ~ 2024.01.31', '2024.02.01', DateTime(2024, 1, 1), DateTime(2024, 1, 31)),
      _ReportItem('2024년 2주차 주간 리포트', '2024.01.08 ~ 2024.01.14', '2024.01.15', DateTime(2024, 1, 8), DateTime(2024, 1, 14)),
      _ReportItem('2024년 1주차 주간 리포트', '2024.01.01 ~ 2024.01.07', '2024.01.08', DateTime(2024, 1, 1), DateTime(2024, 1, 7)),
      _ReportItem('2023년 12월 계측 리포트', '2023.12.01 ~ 2023.12.31', '2024.01.01', DateTime(2023, 12, 1), DateTime(2023, 12, 31)),
      _ReportItem('2023년 연간 계측 리포트', '2023.01.01 ~ 2023.12.31', '2024.01.15', DateTime(2023, 1, 1), DateTime(2023, 12, 31)),
      _ReportItem('2024년 연간 계측 리포트', '2024.01.01 ~ 2024.12.31', '2024.12.31', DateTime(2024, 1, 1), DateTime(2024, 12, 31)),
      _ReportItem('2022년 6월 계측 리포트', '2022.06.01 ~ 2022.06.30', '2022.07.01', DateTime(2022, 6, 1), DateTime(2022, 6, 30)),
    ];

    final filtered = allReports.where((r) {
      // 리포트 기간이 선택한 범위와 겹치는지 확인
      final reportStart = r.startDate;
      final reportEnd = r.endDate;
      return !(reportEnd.isBefore(_rangeStart) || reportStart.isAfter(_rangeEnd));
    }).toList();

    if (filtered.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDesignSystem.spacingXl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined, size: 48, color: AppDesignSystem.textPlaceholder),
                const SizedBox(height: AppDesignSystem.spacingMd),
                Text(
                  '해당 기간의 리포트가 없습니다.',
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeSm,
                    color: AppDesignSystem.textCaption,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return filtered.map((r) => _buildReportCard(r)).toList();
  }

  Widget _buildReportCard(_ReportItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDesignSystem.spacingMd),
      padding: const EdgeInsets.all(AppDesignSystem.spacingMd),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppDesignSystem.slate100,
              borderRadius: AppDesignSystem.borderRadiusLg,
            ),
            child: Icon(Icons.description, color: AppDesignSystem.textSecondary),
          ),
          const SizedBox(width: AppDesignSystem.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeSm,
                    fontWeight: AppDesignSystem.fontWeightMedium,
                    color: AppDesignSystem.textTitle,
                  ),
                ),
                const SizedBox(height: AppDesignSystem.spacingXs),
                Text(
                  item.period,
                  style: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeXs,
                    color: AppDesignSystem.textCaption,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.generateDate,
                style: const TextStyle(
                  fontSize: AppDesignSystem.fontSizeXs,
                  color: AppDesignSystem.textCaption,
                ),
              ),
              const SizedBox(height: AppDesignSystem.spacingSm),
              TextButton(
                onPressed: () {},
                child: const Text('다운로드'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportItem {
  final String title;
  final String period;
  final String generateDate;
  final DateTime startDate;
  final DateTime endDate;

  _ReportItem(this.title, this.period, this.generateDate, this.startDate, this.endDate);
}
