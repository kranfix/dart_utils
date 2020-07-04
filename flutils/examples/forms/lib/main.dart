import 'package:flutter/material.dart';
import 'package:flutils/flutils.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PasswordExample(),
      ),
    );
  }
}

class PasswordExample extends StatefulWidget {
  @override
  _PasswordExampleState createState() => _PasswordExampleState();
}

class _PasswordExampleState extends State<PasswordExample> {
  PasswordEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PasswordEditingController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 30);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            obscureText: _controller.obscureText,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_controller.showText
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: _controller.toggleShowText,
              ),
              hintText: 'Enter a password',
            ),
          ),
          SizedBox(
            height: 30,
            child: _controller.wasSelected
                ? Text('Password must be not empty', style: style)
                : null,
          ),
          Text('${_controller.text}', style: style),
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
