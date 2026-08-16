
import 'package:flutter_test/flutter_test.dart';

import 'package:student_dashboard/main.dart';

void main() {
  testWidgets('App loads Dashboard screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the dashboard title is present.
    expect(find.text('Dashboard'), findsWidgets);
  });
}
