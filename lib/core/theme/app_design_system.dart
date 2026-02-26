import 'package:flutter/material.dart';

/// 유현건설 계측 모니터링 — 디자인 시스템 (Flutter)
/// 웹(Next.js)과 동일한 시각 스타일 적용
class AppDesignSystem {
  AppDesignSystem._();

  // ─── Slate (회색 계열) ─────────────────────────────────────────
  static const Color slate50 = Color(0xFFf8fafc);
  static const Color slate100 = Color(0xFFf1f5f9);
  static const Color slate200 = Color(0xFFe2e8f0);
  static const Color slate300 = Color(0xFFcbd5e1);
  static const Color slate400 = Color(0xFF94a3b8);
  static const Color slate500 = Color(0xFF64748b);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1e293b);
  static const Color slate900 = Color(0xFF0f172a);

  // ─── 시맨틱 색상 ───────────────────────────────────────────────
  static const Color bgPrimary = Color(0xFFffffff);
  static const Color sidebarBg = slate50;
  static const Color cardBg = Color(0xFFffffff);
  static const Color borderDefault = slate200;
  static const Color borderLight = slate100;
  static const Color textTitle = slate900;
  static const Color textBody = slate800;
  static const Color textSubtitle = slate700;
  static const Color textSecondary = slate600;
  static const Color textCaption = slate500;
  static const Color textPlaceholder = slate400;
  static const Color hoverBg = slate100;
  static const Color selectedBg = slate200;
  static const Color focusRing = slate300;

  // ─── 상태/강조 색상 ───────────────────────────────────────────
  static const Color amberBg = Color(0xFFfffbeb);
  static const Color amber600 = Color(0xFFd97706);
  static const Color emeraldBg = Color(0xFFecfdf5);
  static const Color emerald600 = Color(0xFF059669);
  static const Color red600 = Color(0xFFdc2626);
  static const Color redBg = Color(0xFFfef2f2);
  static const Color blue600 = Color(0xFF2563eb);
  static const Color buttonPrimary = slate700;
  static const Color buttonPrimaryDark = slate800;

  // ─── 차트 색상 ─────────────────────────────────────────────────
  static const Color chartGrid = Color(0xFFe2e8f0);
  static const Color chartAxis = Color(0xFF64748b);
  static const Color chartLineOrange = Color(0xFFf97316);
  static const Color chartLineBlue = Color(0xFF3b82f6);
  static const Color pieUndefined = Color(0xFF3b82f6);
  static const Color pieRunning = Color(0xFFf97316);
  static const Color pieStopped = Color(0xFF15803d);
  static const Color pieWarning = Color(0xFF22c55e);

  // ─── 오버레이 ─────────────────────────────────────────────────
  static const Color overlayBg = Color(0x80000000);

  // ─── 간격 (Spacing) ───────────────────────────────────────────
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // ─── 폰트 크기 ─────────────────────────────────────────────────
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeTitle = 24.0;

  // ─── 폰트 굵기 ─────────────────────────────────────────────────
  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemibold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // ─── 레이아웃 ───────────────────────────────────────────────────
  static const double sidebarWidth = 224.0;
  static const double mobileAppBarHeight = 56.0;
  static const double chartHeight = 280.0;
  static const double breakpointMd = 768.0;

  // ─── 모서리 ─────────────────────────────────────────────────────
  static const double radiusLg = 8.0;
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);

  // ─── 애니메이션 ─────────────────────────────────────────────────
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Curve curveDefault = Curves.easeOut;
}
