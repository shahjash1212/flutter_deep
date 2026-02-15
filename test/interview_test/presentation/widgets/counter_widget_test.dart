import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_deep/interview_test/presentation/widgets/counter_widget.dart';
import 'package:flutter_deep/interview_test/presentation/providers/counter_provider.dart';

void main() {
  group('CounterWidget', () {
    testWidgets('displays initial count of 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CounterWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Count: 0'), findsOneWidget);
    });

    testWidgets('increments count when button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CounterWidget(),
            ),
          ),
        ),
      );

      expect(find.text('Count: 0'), findsOneWidget);

      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();

      expect(find.text('Count: 1'), findsOneWidget);
    });

    testWidgets('increments multiple times', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CounterWidget(),
            ),
          ),
        ),
      );

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byKey(const Key('increment_button')));
        await tester.pump();
      }

      expect(find.text('Count: 5'), findsOneWidget);
    });

    testWidgets('displays increment button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CounterWidget(),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('increment_button')), findsOneWidget);
      expect(find.text('Increment'), findsOneWidget);
    });

    testWidgets('count text has correct key', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: CounterWidget(),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('count_text')), findsOneWidget);
    });
  });
}
