import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gen_x_radio/app.dart'; // Update to actual entry point file

void main() {
  testWidgets('Radio app loads and plays a station', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title appears.
    expect(find.text('Live Radio'), findsOneWidget);

    // Expect at least one known station (e.g., Metro FM).
    expect(find.text('Metro FM'), findsOneWidget);

    // Tap on Metro FM to play it.
    await tester.tap(find.text('Metro FM'));
    await tester.pump(); // Trigger widget tree update

    // Expect mini player to show up with the station name.
    expect(find.text('Metro FM'), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget); // Player starts in play state
  });
}
