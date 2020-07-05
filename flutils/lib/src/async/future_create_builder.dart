import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FutureCreateBuilder<T> extends StatefulWidget {
  const FutureCreateBuilder({
    Key key,
    @required this.create,
    this.initialData,
    @required this.builder,
  })  : assert(create != null),
        assert(builder != null),
        super(key: key);

  /// Creates a Future<T>
  final AsyncValueGetter<T> create;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  @override
  _FutureCreateBuilderState<T> createState() => _FutureCreateBuilderState<T>();
}

class _FutureCreateBuilderState<T> extends State<FutureCreateBuilder<T>> {
  AsyncSnapshot<T> _snapshot;
  Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.create();
    _snapshot =
        AsyncSnapshot<T>.withData(ConnectionState.none, widget.initialData);
    _subscribe();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _snapshot);

  void _subscribe() {
    _future.then<void>((T data) {
      setState(() {
        _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
      });
    }, onError: (Object error) {
      setState(() {
        _snapshot = AsyncSnapshot<T>.withError(ConnectionState.done, error);
      });
    });
    _snapshot = _snapshot.inState(ConnectionState.waiting);
  }
}
