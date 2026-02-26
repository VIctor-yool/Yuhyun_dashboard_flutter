import 'package:flutter/material.dart';
import '../../../../core/theme/app_design_system.dart';

/// QR 조회 — QR 코드로 계측 현장/장비 조회
class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final _controller = TextEditingController();
  String? _searchResult;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildScanSection(),
          const SizedBox(height: AppDesignSystem.spacingXl),
          _buildManualInputSection(),
          if (_searchResult != null) ...[
            const SizedBox(height: AppDesignSystem.spacingXl),
            _buildResultSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildScanSection() {
    return Container(
      padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppDesignSystem.slate100,
              borderRadius: AppDesignSystem.borderRadiusLg,
            ),
            child: Icon(
              Icons.qr_code_scanner,
              size: 80,
              color: AppDesignSystem.textPlaceholder,
            ),
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          const Text(
            'QR 코드를 스캔하세요',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              color: AppDesignSystem.textSecondary,
            ),
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          FilledButton.icon(
            onPressed: () {
              setState(() => _searchResult = '현장-A-01 | 센서 12개 연결');
            },
            icon: const Icon(Icons.qr_code_scanner, size: 20),
            label: const Text('스캔 시작'),
          ),
        ],
      ),
    );
  }

  Widget _buildManualInputSection() {
    return Container(
      padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
      decoration: BoxDecoration(
        color: AppDesignSystem.cardBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '수동 입력',
            style: TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              fontWeight: AppDesignSystem.fontWeightSemibold,
              color: AppDesignSystem.textTitle,
            ),
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'QR 코드 또는 현장 ID 입력',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              setState(() => _searchResult = value.isEmpty ? null : '검색 결과: $value');
            },
          ),
          const SizedBox(height: AppDesignSystem.spacingMd),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                setState(() => _searchResult = _controller.text.isEmpty
                    ? null
                    : '현장-${_controller.text} | 센서 8개 연결');
              },
              child: const Text('조회'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    return Container(
      padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
      decoration: BoxDecoration(
        color: AppDesignSystem.emeraldBg,
        borderRadius: AppDesignSystem.borderRadiusLg,
        border: Border.all(color: AppDesignSystem.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: AppDesignSystem.emerald600, size: 24),
              const SizedBox(width: AppDesignSystem.spacingSm),
              const Text(
                '조회 결과',
                style: TextStyle(
                  fontSize: AppDesignSystem.fontSizeSm,
                  fontWeight: AppDesignSystem.fontWeightSemibold,
                  color: AppDesignSystem.textTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignSystem.spacingSm),
          Text(
            _searchResult!,
            style: const TextStyle(
              fontSize: AppDesignSystem.fontSizeSm,
              color: AppDesignSystem.textBody,
            ),
          ),
        ],
      ),
    );
  }
}
