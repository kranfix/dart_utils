// ignore_for_file: public_member_api_docs

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Empty'),
              ),
              Tab(
                child: Text('Initilized'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: PasswordExample(),
            ),
            Center(
              child: PasswordExample(initialPassword: 'password'),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordExample extends StatefulWidget {
  const PasswordExample({super.key, this.initialPassword = ''});

  final String initialPassword;

  @override
  State<PasswordExample> createState() => _PasswordExampleState();
}

class _PasswordExampleState extends State<PasswordExample> {
  late PasswordEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PasswordEditingController(text: widget.initialPassword);
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 20);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            obscureText: _controller.obscureText,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _controller.showText
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: _controller.toggleShowText,
              ),
              hintText: 'Enter a password',
            ),
          ),
          SizedBox(
            height: 30,
            child: _controller.wasSelected
                ? const Text('Password must be not empty', style: style)
                : null,
          ),
          Text(_controller.text, style: style),
          Text('Is Edited? ${_controller.isEdited}', style: style),
          Text('Is not edited? ${_controller.isNotEdited}', style: style),
          Text('Was selected? ${_controller.wasSelected}', style: style),
          Text('was not selected? ${_controller.wasNotSelected}', style: style),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
