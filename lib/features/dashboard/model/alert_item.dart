import 'package:flutter/material.dart';

/// 알림 항목
class AlertItem {
  final String title;
  final String type; // '경고', '오류', '정상'
  final Color color;
  final String time;

  const AlertItem({
    required this.title,
    required this.type,
    required this.color,
    required this.time,
  });
}
