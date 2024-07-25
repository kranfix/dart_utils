// ignore_for_file: public_member_api_docs

import 'dart:math';
import 'package:flutils/flutils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, super.key});

  /// title of the app bar
  final String title;

  /// Fetch a random number
  Future<int> fetchNumber() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    return Random(3434).nextInt(34);
    //throw Exception('Forced error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: FutureCreateBuilder<int>(
          create: fetchNumber,
          initialData: 23,
          builder: (_, snapshot) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                'data: ${snapshot.data}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'hasData: ${snapshot.hasData}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'hasError: ${snapshot.hasError}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'error: ${snapshot.error}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                '${snapshot.connectionState}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                SizedBox.fromSize(
                  size: const Size.square(30),
                  child: const CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
