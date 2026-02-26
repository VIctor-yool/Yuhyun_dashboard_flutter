import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard/main.dart';

void main() {
  testWidgets('App loads and shows dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('통합 대시보드'), findsOneWidget);
  });
}
