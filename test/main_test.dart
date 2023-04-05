import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Hello World'),
      ),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Hello World'), findsOneWidget);
  });
}
