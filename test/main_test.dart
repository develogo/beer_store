import 'package:beer_store/app/config/app.dart';
import 'package:beer_store/app/di/di_setup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test that app can be loaded without errors',
      (WidgetTester tester) async {
    // Setup dependencies
    configureDependencies();

    // Build the app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the app was loaded without errors.
    expect(tester.takeException(), isNull);
  });
}
