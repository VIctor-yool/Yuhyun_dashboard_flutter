import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_design_system.dart';

/// Bootstrap 스타일 달력 모달 (기간 선택)
class BootstrapCalendarModal extends StatefulWidget {
  final DateTime initialStart;
  final DateTime initialEnd;
  final void Function(DateTime start, DateTime end) onRangeSelected;

  const BootstrapCalendarModal({
    super.key,
    required this.initialStart,
    required this.initialEnd,
    required this.onRangeSelected,
  });

  @override
  State<BootstrapCalendarModal> createState() => _BootstrapCalendarModalState();
}

class _BootstrapCalendarModalState extends State<BootstrapCalendarModal> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialStart;
    _rangeStart = widget.initialStart;
    _rangeEnd = widget.initialEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: AppDesignSystem.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppDesignSystem.borderDefault),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppDesignSystem.borderDefault),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ExcludeSemantics(
                child: TableCalendar(
                  firstDay: DateTime(2020, 1, 1),
                  lastDay: DateTime(2030, 12, 31),
                  focusedDay: _focusedDay,
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  rangeSelectionMode: RangeSelectionMode.enforced,
                  locale: 'ko_KR',
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: const Icon(Icons.chevron_left),
                  rightChevronIcon: const Icon(Icons.chevron_right),
                  headerPadding: const EdgeInsets.symmetric(vertical: 12),
                  titleTextStyle: const TextStyle(
                    fontSize: AppDesignSystem.fontSizeSm,
                    fontWeight: AppDesignSystem.fontWeightSemibold,
                    color: AppDesignSystem.textTitle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(
                    fontSize: 11,
                    color: AppDesignSystem.textSecondary,
                    fontWeight: AppDesignSystem.fontWeightMedium,
                  ),
                  weekendStyle: const TextStyle(
                    fontSize: 11,
                    color: AppDesignSystem.textCaption,
                    fontWeight: AppDesignSystem.fontWeightMedium,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  cellMargin: const EdgeInsets.all(4),
                  defaultTextStyle: const TextStyle(
                    fontSize: 13,
                    color: AppDesignSystem.textBody,
                  ),
                  weekendTextStyle: const TextStyle(
                    fontSize: 13,
                    color: AppDesignSystem.textCaption,
                  ),
                  outsideTextStyle: const TextStyle(
                    fontSize: 13,
                    color: AppDesignSystem.textPlaceholder,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppDesignSystem.blue600,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppDesignSystem.slate200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  rangeStartDecoration: BoxDecoration(
                    color: AppDesignSystem.blue600,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: AppDesignSystem.blue600,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  rangeHighlightColor: Color.lerp(Colors.white, AppDesignSystem.blue600, 0.2)!,
                  withinRangeTextStyle: const TextStyle(
                    fontSize: 13,
                    color: AppDesignSystem.textBody,
                  ),
                ),
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _rangeStart = start;
                    _rangeEnd = end ?? start;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() => _focusedDay = focusedDay);
                },
              ),
            ),
          ),
            const SizedBox(height: 16),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '기간 선택',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              fontWeight: AppDesignSystem.fontWeightBold,
              color: AppDesignSystem.textTitle,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppDesignSystem.borderDefault),
              ),
              child: const Text('취소'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: () {
                if (_rangeStart != null && _rangeEnd != null) {
                  widget.onRangeSelected(_rangeStart!, _rangeEnd!);
                  Navigator.pop(context);
                } else if (_rangeStart != null) {
                  widget.onRangeSelected(_rangeStart!, _rangeStart!);
                  Navigator.pop(context);
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppDesignSystem.blue600,
              ),
              child: const Text('적용'),
            ),
          ),
        ],
      ),
    );
  }
}
