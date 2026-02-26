import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../shared/widgets/card_container.dart';
import '../model/report_item.dart';
import 'widgets/period_selector.dart';

/// 자동 리포트 — 자동 생성 리포트 목록
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _periodFilter = 'month';
  DateTime _rangeStart = DateTime(2024, 1, 1);
  DateTime _rangeEnd = DateTime(2024, 2, 29);

  void _onPeriodFilterChanged(String value) {
    setState(() {
      _periodFilter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PeriodFilterBar(
          periodFilter: _periodFilter,
          onPeriodFilterChanged: _onPeriodFilterChanged,
          periodSelector: PeriodSelector(
            periodFilter: _periodFilter,
            rangeStart: _rangeStart,
            rangeEnd: _rangeEnd,
            onRangeStartChanged: (v) => setState(() => _rangeStart = v),
            onRangeEndChanged: (v) => setState(() => _rangeEnd = v),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
            children: _buildReportList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildReportList() {
    final allReports = [
      ReportItem(
        title: '2024년 2월 계측 리포트',
        period: '2024.02.01 ~ 2024.02.29',
        generateDate: '2024.03.01',
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 29),
      ),
      ReportItem(
        title: '2024년 1월 계측 리포트',
        period: '2024.01.01 ~ 2024.01.31',
        generateDate: '2024.02.01',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 31),
      ),
      ReportItem(
        title: '2024년 2주차 주간 리포트',
        period: '2024.01.08 ~ 2024.01.14',
        generateDate: '2024.01.15',
        startDate: DateTime(2024, 1, 8),
        endDate: DateTime(2024, 1, 14),
      ),
      ReportItem(
        title: '2024년 1주차 주간 리포트',
        period: '2024.01.01 ~ 2024.01.07',
        generateDate: '2024.01.08',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 7),
      ),
      ReportItem(
        title: '2023년 12월 계측 리포트',
        period: '2023.12.01 ~ 2023.12.31',
        generateDate: '2024.01.01',
        startDate: DateTime(2023, 12, 1),
        endDate: DateTime(2023, 12, 31),
      ),
      ReportItem(
        title: '2023년 연간 계측 리포트',
        period: '2023.01.01 ~ 2023.12.31',
        generateDate: '2024.01.15',
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 12, 31),
      ),
      ReportItem(
        title: '2024년 연간 계측 리포트',
        period: '2024.01.01 ~ 2024.12.31',
        generateDate: '2024.12.31',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 31),
      ),
      ReportItem(
        title: '2022년 6월 계측 리포트',
        period: '2022.06.01 ~ 2022.06.30',
        generateDate: '2022.07.01',
        startDate: DateTime(2022, 6, 1),
        endDate: DateTime(2022, 6, 30),
      ),
    ];

    final filtered = allReports.where((r) {
      return !(r.endDate.isBefore(_rangeStart) || r.startDate.isAfter(_rangeEnd));
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

  Widget _buildReportCard(ReportItem item) {
    return AppCardContainer(
      margin: const EdgeInsets.only(bottom: AppDesignSystem.spacingMd),
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
