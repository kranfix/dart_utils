import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutils/flutils.dart';

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
              Text('You have pushed the button this many times:'),
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
  group('API non null verifications', () {
    test('create parameter should be non null', () {
      try {
        createWidget<double>(null, null);
      } catch (e) {
        expect(e, isA<AssertionError>());
      }
    });

    test('builder should be non null', () {
      try {
        FutureCreateBuilder<String>(
          create: () => Future.value('Hola error!'),
          builder: null,
        );
      } catch (e) {
        expect(e, isA<AssertionError>());
      }
    });
  });

  group('Testing FutureCreateBuilder with initial=null and hasData', () {
    final widget = createWidget<int>(() async {
      await Future.delayed(Duration(seconds: 3));
      return 5;
    }, null);

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
      await tester.pump(Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 5');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with initial=null and hasError', () {
    final widget = createWidget<int>(() async {
      await Future.delayed(Duration(seconds: 3));
      throw Exception('Forced error');
    }, null);

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
      await tester.pump(Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: Exception: Forced error');
      final hasErrorTextFinder = find.text('hasError: true');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with non null initialData and hasData',
      () {
    final widget = createWidget<int>(() async {
      await Future.delayed(Duration(seconds: 3));
      return 5;
    }, 23);

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
      await tester.pump(Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: 5');
      final hasDataTextFinder = find.text('hasData: true');
      final errorTextFinder = find.text('error: null');
      final hasErrorTextFinder = find.text('hasError: false');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });

  group('Testing FutureCreateBuilder with non null initialData and hasError',
      () {
    final widget = createWidget<int>(() async {
      await Future.delayed(Duration(seconds: 3));
      throw Exception('Forced error');
    }, 23);

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
      await tester.pump(Duration(seconds: 3));
    });

    testWidgets('Final state', (WidgetTester tester) async {
      final dataTextFinder = find.text('data: null');
      final hasDataTextFinder = find.text('hasData: false');
      final errorTextFinder = find.text('error: Exception: Forced error');
      final hasErrorTextFinder = find.text('hasError: true');
      final connectionStateTextFinder = find.text('ConnectionState.done');
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 3));
      expect(dataTextFinder, findsOneWidget);
      expect(hasDataTextFinder, findsOneWidget);
      expect(errorTextFinder, findsOneWidget);
      expect(hasErrorTextFinder, findsOneWidget);
      expect(connectionStateTextFinder, findsOneWidget);
    });
  });
}
