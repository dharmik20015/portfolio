import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp loads successfully and disposes cleanly', (WidgetTester tester) async {
    // Set a realistic desktop screen size for the test
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Dharmik Rakholiya'), findsWidgets);

    // Dispose the widget tree so all timers and animation controllers are cleaned up
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}
