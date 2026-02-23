# dashboard

앱 플랫폼 모니터링 대시보드 (Flutter)

## 대시보드 구현 가이드 (목업)

### 1. 사용 라이브러리 및 UI

**차트**
- **fl_chart** (^0.66.0): Flutter 전용 차트 라이브러리
  - 선 그래프(LineChart): 트래픽, 사용량, 상위 5개 앱 트렌드
  - 원형 차트(PieChart): 운영 모니터링 도넛 차트
- 대안: syncfusion_flutter_charts, charts_flutter 등

**UI·스타일**
- Flutter Material 3: 기본 위젯, 테마
- 반응형: SingleChildScrollView, 가로 스크롤 ListView(KPI 카드)
- 모바일 UX: 햄버거 메뉴 → endDrawer로 사이드바 표시

**추천 조합 (확장 시)**
- 상태 관리: Provider, Riverpod, Bloc
- 라우팅: go_router
- API: dio, http

### 2. 반응형 및 웹 연동

**플러터(모바일) 구현**
- KPI 카드: 가로 스크롤 (ListView horizontal)
- 차트: 고정 높이 SizedBox 내 fl_chart
- 메뉴: 작은 화면에서 햄버거 → endDrawer

**웹 ↔ 플러터 관계**
- 화면·기능·데이터는 동일하게 구현 가능
- 라이브러리·코드·반응형 구현 방식은 웹과 플러터가 완전히 다름

| 구분 | 웹 (Next.js) | 모바일 (Flutter) |
|------|--------------|------------------|
| 프레임워크 | Next.js (React) | Flutter (Dart) |
| 차트 | Recharts | fl_chart |
| 스타일/반응형 | Tailwind, ResponsiveContainer | Flutter 위젯, MediaQuery |
| 코드 공유 | ❌ 불가 | ❌ 불가 |

**공유하는 것**: 백엔드 API, 데이터 스키마, 화면/메뉴 기획

### 3. 폴더 구조

```
dashboard/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── shared/
│   │   └── layout/
│   │       ├── app_scaffold.dart    # 메인 스캐폴드 (AppBar, endDrawer, body)
│   │       └── app_menu_drawer.dart # 햄버거 메뉴 드로어
│   └── features/
│       ├── dashboard/
│       │   ├── model/
│       │   │   ├── dashboard_summary.dart
│       │   │   └── traffic_point.dart
│       │   ├── data/
│       │   │   └── dashboard_repository.dart
│       │   └── ui/
│       │       ├── dashboard_screen.dart      # 통합 대시보드
│       │       ├── placeholder_screen.dart    # 모니터링/알림/QR/리포트 플레이스홀더
│       │       └── widgets/
│       │           ├── summary_card.dart           # KPI 요약 카드
│       │           ├── traffic_line_chart.dart     # 트래픽 선 그래프
│       │           ├── usage_line_chart.dart       # 사용량 선 그래프
│       │           ├── traffic_trend_chart.dart    # 상위 5개 앱 트렌드
│       │           ├── donut_chart_widget.dart     # 운영 모니터링 원형 차트
│       │           └── section_header.dart         # 섹션 헤더 (새로고침)
│       └── auth/
│           └── ui/
│               └── login_page.dart  # 로그인/회원가입
├── docs/
│   └── 대시보드_구현_가이드.md
├── pubspec.yaml
└── README.md
```

**메뉴 구성**: 통합 대시보드, 실시간 모니터링, 알림, QR 조회, 자동 리포트, 로그인/회원가입

**진입 경로**: 앱 실행 시 통합 대시보드가 처음 선택된 화면으로 표시됩니다.

### 4. 실행 방법

```bash
cd dashboard
flutter pub get
flutter run -d windows   # 또는 chrome, android 등
```
