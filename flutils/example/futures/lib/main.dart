import 'dart:math';
import 'package:flutils/flutils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  Future<int> fetchNumber() async {
    final random = Random(3434);
    await Future.delayed(Duration(seconds: 5));
    //return random.nextInt(34);
    throw Exception('Forced error');
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
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                'data: ${snapshot.data}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'hasData: ${snapshot.hasData}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'hasError: ${snapshot.hasError}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'error: ${snapshot.error}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '${snapshot.connectionState}',
                style: Theme.of(context).textTheme.headline6,
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                SizedBox.fromSize(
                  size: Size.square(30),
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
