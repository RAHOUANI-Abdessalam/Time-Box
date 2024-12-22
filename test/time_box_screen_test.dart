import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_box/generated/l10n.dart';
import 'package:time_box/screens/time_box_screen.dart';

void main() {
  group('TimeBoxScreen Widget Tests', () {
    testWidgets('TimeBoxScreen should build without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: const [
          S.delegate,
        ],
        home: TimeBoxScreen(
          onLanguageChanged: (locale) {},
        ),
      ));

      expect(find.text('TimeBox'), findsAtLeast(1));
    });

    // Test case for checking if the language selection dialog opens
    testWidgets('Language selection dialog should open on button tap',
        (WidgetTester tester) async {
      // Build the TimeBoxScreen widget
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: const [
          S.delegate,
        ],
        home: TimeBoxScreen(
          onLanguageChanged: (locale) {},
        ),
      ));

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pump();

      expect(find.text('Select Language'), findsOneWidget);
    });

    // Test case for verifying data initialization
    testWidgets('Data should be initialized correctly on screen load',
        (WidgetTester tester) async {
      // Build the TimeBoxScreen widget
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: const [
          S.delegate,
        ],
        home: TimeBoxScreen(
          onLanguageChanged: (locale) {},
        ),
      ));

      // Verify that the initial data is loaded and displayed correctly
      expect(find.text('Ex task'), findsOneWidget);
    });

    // // Test case for table selection
    // testWidgets('Table selection should highlight the selected item',
    //     (WidgetTester tester) async {
    //   // Build the TimeBoxScreen widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       localizationsDelegates: const [
    //         S.delegate,
    //       ],
    //       home: TimeBoxScreen(onLanguageChanged: (locale) {}),
    //     ),
    //   );

    //   // Simulate selecting an item in the table
    //   await tester.tap(find.byKey(_braindumpExpandedKey));
    //   await tester.pump();

    //   // Verify that the selected item is highlighted
    //   expect(find.byKey(_braindumpFullKey), findsOneWidget);
    //   // expect(selectedItemColor, equals(highlightColor));
    // });

    // // Test case for task handling
    // testWidgets('Task handling should update task status correctly',
    //     (WidgetTester tester) async {
    //   // Build the TimeBoxScreen widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //               localizationsDelegates: const [
    //       S.delegate,
    //     ],
    //       home: TimeBoxScreen( onLanguageChanged: (locale) {}),
    //     ),
    //   );

    //   // Simulate performing a task action
    //   await tester.tap(find.byKey(taskActionButtonKey));
    //   await tester.pump();

    //   // Verify that the task status is updated as expected
    //   expect(find.text('Task Completed'), findsOneWidget);
    // });

    // // Test case for animation testing
    // testWidgets('Animation should play when triggered',
    //     (WidgetTester tester) async {
    //   // Build the TimeBoxScreen widget
    //   await tester.pumpWidget(
    //     MaterialApp(
    //               localizationsDelegates: const [
    //       S.delegate,
    //     ],
    //       home: TimeBoxScreen( onLanguageChanged: (locale) {}),
    //     ),
    //   );

    //   // Simulate triggering the animation
    //   await tester.tap(find.byKey(animationTriggerKey));
    //   await tester.pumpAndSettle();

    //   // Verify that the animation is played
    //   expect(find.byKey(animationKey), findsOneWidget);
    // });

    // Add more test cases for table selection, task handling, and animation testing as needed
  });
}
