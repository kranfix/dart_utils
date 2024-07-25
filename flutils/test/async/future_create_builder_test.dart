import 'package:flutils/flutils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidget<T>(
  AsyncValueGetter<T> create,
  T initialData,
) {
  return MaterialApp(
    title: 'FutureCreateBuilder test',
    home: Scaffold(
      body: FutureCreateBuilder<T>(
        create: create,
        initialData: initialData,
        builder: (_, snapshot) => Center(
          child: Column(
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text('data: ${snapshot.data}'),
              Text('hasData: ${snapshot.hasData}'),
              Text('error: ${snapshot.error}'),
              Text('hasError: ${snapshot.hasError}'),
              Text('${snapshot.connectionState}'),
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('Testing FutureCreateBuilder with initial=null and hasData', () {
    final widget = createWidget<int?>(
      () async {
        await Future<void>.delayed(const Duration(seconds: 3));
        return 5;
      },
      null,
    );

    testWidgets('Initial conditions', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.waiting');
      await tester.pumpWidget(widget);
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 5');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with initial=null and hasError', () {
    final widget = createWidget<int?>(
      () async {
        await Future<void>.delayed(const Duration(seconds: 3));
        throw Exception('Forced error');
      },
      null,
    );

    testWidgets('Initial conditions', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.waiting');
      await tester.pumpWidget(widget);
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: Exception: Forced error');
      final hasErrorTextFinder = find.text('hasError: true');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with non null initialData and hasData',
      () {
    final widget = createWidget<int>(
      () async {
        await Future<void>.delayed(const Duration(seconds: 3));
        return 5;
      },
      23,
    );

    testWidgets('Initial conditions', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 23');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.waiting');
      await tester.pumpWidget(widget);
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 5');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with non null initialData and hasError',
      () {
    final widget = createWidget<int>(
      () async {
        await Future<void>.delayed(const Duration(seconds: 3));
        throw Exception('Forced error');
      },
      23,
    );

    testWidgets('Initial conditions', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 23');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.waiting');
      await tester.pumpWidget(widget);
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: Exception: Forced error');
      final hasErrorTextFinder = find.text('hasError: true');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });
}
