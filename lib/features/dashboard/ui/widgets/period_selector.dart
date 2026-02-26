import 'package:flutter/material.dart';
import '../../../../../core/theme/app_design_system.dart';
import '../../../../../core/utils/date_utils.dart' as app_date;
import '../../../../../shared/widgets/filter_chip.dart';
import 'bootstrap_calendar_modal.dart';

/// 기간 선택 위젯 (주간/월간/연간/기간선택 + 날짜 입력)
class PeriodSelector extends StatefulWidget {
  final String periodFilter;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final ValueChanged<DateTime> onRangeStartChanged;
  final ValueChanged<DateTime> onRangeEndChanged;

  const PeriodSelector({
    super.key,
    required this.periodFilter,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onRangeStartChanged,
    required this.onRangeEndChanged,
  });

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedWeek;

  bool get _isDatePickerEnabled => widget.periodFilter == 'range';

  @override
  void initState() {
    super.initState();
    _initFromRange();
  }

  @override
  void didUpdateWidget(PeriodSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.periodFilter != widget.periodFilter ||
        oldWidget.rangeStart != widget.rangeStart ||
        oldWidget.rangeEnd != widget.rangeEnd) {
      if (widget.periodFilter != 'range') {
        _initFromRange();
        _syncRange();
      }
    }
  }

  int get _weeksInMonth => app_date.AppDateUtils.weeksInMonth(_selectedYear, _selectedMonth);

  void _initFromRange() {
    _selectedYear = widget.rangeStart.year;
    _selectedMonth = widget.rangeStart.month;
    _selectedWeek = app_date.AppDateUtils.weekOfMonth(widget.rangeStart);
  }

  void _syncRange() {
    switch (widget.periodFilter) {
      case 'week':
        final week = _selectedWeek.clamp(1, _weeksInMonth);
        final (start, end) = app_date.AppDateUtils.getWeekRange(_selectedYear, _selectedMonth, week);
        widget.onRangeStartChanged(start);
        widget.onRangeEndChanged(end);
        break;
      case 'month':
        widget.onRangeStartChanged(DateTime(_selectedYear, _selectedMonth, 1));
        widget.onRangeEndChanged(DateTime(_selectedYear, _selectedMonth + 1, 0));
        break;
      case 'year':
        widget.onRangeStartChanged(DateTime(_selectedYear, 1, 1));
        widget.onRangeEndChanged(DateTime(_selectedYear, 12, 31));
        break;
      default:
        break;
    }
  }

  Future<void> _showCalendarModal() async {
    if (!_isDatePickerEnabled) return;
    await showDialog(
      context: context,
      barrierColor: AppDesignSystem.overlayBg,
      builder: (ctx) => BootstrapCalendarModal(
        initialStart: widget.rangeStart,
        initialEnd: widget.rangeEnd,
        onRangeSelected: (start, end) {
          widget.onRangeStartChanged(start);
          widget.onRangeEndChanged(end);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppDesignSystem.bgPrimary,
        border: Border.all(color: AppDesignSystem.borderDefault),
        borderRadius: AppDesignSystem.borderRadiusLg,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCalendarIcon(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildCalendarIcon() {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 4, 9, 4),
      decoration: BoxDecoration(
        color: _isDatePickerEnabled ? AppDesignSystem.bgPrimary : AppDesignSystem.slate100,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppDesignSystem.radiusLg)),
      ),
      child: GestureDetector(
        onTap: _isDatePickerEnabled ? _showCalendarModal : null,
        child: Icon(
          Icons.calendar_month,
          size: AppDesignSystem.calendarIconSize,
          color: _isDatePickerEnabled ? AppDesignSystem.textSecondary : AppDesignSystem.textPlaceholder,
        ),
      ),
    );
  }

  Widget _buildContent() {
    const padding = EdgeInsets.fromLTRB(9, 4, 9, 4);

    if (_isDatePickerEnabled) {
      return InkWell(
        onTap: _showCalendarModal,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(AppDesignSystem.radiusLg)),
        child: Container(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  app_date.AppDateUtils.formatDateRange(widget.rangeStart, widget.rangeEnd),
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
      );
    }

    return Container(
      padding: padding,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildDropdowns(),
        ),
      ),
    );
  }

  List<Widget> _buildDropdowns() {
    final yearItems = List.generate(10, (i) => DateTime.now().year - 5 + i);
    final monthItems = List.generate(12, (i) => i + 1);

    if (widget.periodFilter == 'year') {
      return [
        _buildDropdown(_selectedYear, yearItems, (v) => '$v년', (v) {
          setState(() {
            _selectedYear = v;
            _syncRange();
          });
        }),
      ];
    }

    if (widget.periodFilter == 'month') {
      return [
        _buildDropdown(_selectedYear, yearItems, (v) => '$v년', (v) {
          setState(() {
            _selectedYear = v;
            _syncRange();
          });
        }),
        const SizedBox(width: AppDesignSystem.spacingSm),
        _buildDropdown(_selectedMonth, monthItems, (v) => '$v월', (v) {
          setState(() {
            _selectedMonth = v;
            _syncRange();
          });
        }),
      ];
    }

    // 주간
    final weekItems = List.generate(_weeksInMonth, (i) => i + 1);
    return [
      _buildDropdown(_selectedYear, yearItems, (v) => '$v년', (v) {
        setState(() {
          _selectedYear = v;
          if (_selectedWeek > _weeksInMonth) _selectedWeek = _weeksInMonth;
          _syncRange();
        });
      }),
      const SizedBox(width: AppDesignSystem.spacingSm),
      _buildDropdown(_selectedMonth, monthItems, (v) => '$v월', (v) {
        setState(() {
          _selectedMonth = v;
          if (_selectedWeek > _weeksInMonth) _selectedWeek = _weeksInMonth;
          _syncRange();
        });
      }),
      const SizedBox(width: AppDesignSystem.spacingSm),
      _buildDropdown(
        _selectedWeek.clamp(1, _weeksInMonth),
        weekItems,
        (v) => '$v주차',
        (v) {
          setState(() {
            _selectedWeek = v;
            _syncRange();
          });
        },
      ),
    ];
  }

  Widget _buildDropdown<T>(
    T value,
    List<T> items,
    String Function(T) labelBuilder,
    void Function(T) onChanged,
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isDense: true,
        items: items
            .map((v) => DropdownMenuItem(
                  value: v,
                  child: Text(labelBuilder(v), style: const TextStyle(fontSize: AppDesignSystem.fontSizeSm)),
                ))
            .toList(),
        onChanged: (v) => v != null ? onChanged(v) : null,
      ),
    );
  }
}

/// 기간 필터 바 (칩 + 기간 선택기)
class PeriodFilterBar extends StatelessWidget {
  final String periodFilter;
  final ValueChanged<String> onPeriodFilterChanged;
  final Widget periodSelector;

  const PeriodFilterBar({
    super.key,
    required this.periodFilter,
    required this.onPeriodFilterChanged,
    required this.periodSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignSystem.spacingLg,
        vertical: AppDesignSystem.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        border: Border(bottom: BorderSide(color: AppDesignSystem.borderLight)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChip('주간', 'week'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildChip('월간', 'month'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildChip('연간', 'year'),
            const SizedBox(width: AppDesignSystem.spacingSm),
            _buildChip('기간 선택', 'range'),
            const SizedBox(width: AppDesignSystem.spacingLg),
            SizedBox(width: AppDesignSystem.dateInputWidth, child: periodSelector),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    return AppFilterChip(
      label: label,
      isSelected: periodFilter == value,
      onTap: () => onPeriodFilterChanged(value),
    );
  }
}
