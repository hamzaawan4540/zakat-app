import 'package:flutter_test/flutter_test.dart';

import 'package:zakatoon/main.dart';

void main() {
  testWidgets('Zakatoon app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ZakatoonApp());

    // Wait for splash screen animation
    await tester.pump(const Duration(seconds: 1));

    // Verify app title is displayed
    expect(find.text('Zakatoon'), findsOneWidget);
  });
}
