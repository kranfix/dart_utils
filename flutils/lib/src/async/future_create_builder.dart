import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FutureCreateBuilder<T> extends StatefulWidget {
  const FutureCreateBuilder({
    Key key,
    this.create,
    this.initialData,
    this.builder,
  }) : super(key: key);

  /// Creates a Future<T>
  final AsyncValueGetter<T> create;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  @override
  _FutureCreateBuilderState createState() => _FutureCreateBuilderState();
}

class _FutureCreateBuilderState<T> extends State<FutureCreateBuilder<T>> {
  Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.create?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      initialData: widget.initialData,
      builder: widget.builder,
    );
  }
}
