import 'package:flutter/material.dart';
import 'app_design_system.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        // fontFamily: 'Pretendard' — assets/fonts/Pretendard 추가 후 사용
        colorScheme: ColorScheme.light(
          surface: AppDesignSystem.bgPrimary,
          onSurface: AppDesignSystem.textBody,
          primary: AppDesignSystem.blue600,
          onPrimary: Colors.white,
        ),
        scaffoldBackgroundColor: AppDesignSystem.bgPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppDesignSystem.bgPrimary,
          foregroundColor: AppDesignSystem.textTitle,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppDesignSystem.textTitle,
            fontSize: AppDesignSystem.fontSizeTitle,
            fontWeight: AppDesignSystem.fontWeightBold,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppDesignSystem.cardBg,
          elevation: 1,
          shadowColor: const Color(0x0F000000),
          shape: RoundedRectangleBorder(
            borderRadius: AppDesignSystem.borderRadiusLg,
            side: const BorderSide(color: AppDesignSystem.borderDefault, width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppDesignSystem.bgPrimary,
          border: OutlineInputBorder(
            borderRadius: AppDesignSystem.borderRadiusLg,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDesignSystem.spacingMd,
            vertical: 12,
          ),
          labelStyle: const TextStyle(
            color: AppDesignSystem.textSecondary,
            fontSize: AppDesignSystem.fontSizeSm,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppDesignSystem.buttonPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignSystem.spacingMd,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: AppDesignSystem.borderRadiusLg,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppDesignSystem.blue600,
          ),
        ),
      );
}
