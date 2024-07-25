import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// {@template flutils_FutureCreateBuilder}
/// Similar to [FutureBuilder] but owns the future
/// {@endtemplate}
class FutureCreateBuilder<T> extends StatefulWidget {
  /// {@macro flutils_FutureCreateBuilder}
  const FutureCreateBuilder({
    required this.create,
    required this.initialData,
    required this.builder,
    super.key,
  });

  /// Creates a Future<T>
  final AsyncValueGetter<T> create;

  /// {@template flutils_FutureCreateBuilder_initialData}
  /// Initial data of the FutureCreateBuilder
  /// {@endtemplate}
  final T initialData;

  /// {@template flutils_FutureCreateBuilder_builder}
  /// Builder of the future
  /// {@endtemplate}
  final AsyncWidgetBuilder<T> builder;

  @override
  State<FutureCreateBuilder<T>> createState() => _FutureCreateBuilderState<T>();
}

class _FutureCreateBuilderState<T> extends State<FutureCreateBuilder<T>> {
  late AsyncSnapshot<T> _snapshot;
  late Future<T> _future;

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
    _future.then<void>(
      (T data) {
        setState(() {
          _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
        });
      },
      onError: (Object error) {
        setState(() {
          _snapshot = AsyncSnapshot<T>.withError(ConnectionState.done, error);
        });
      },
    );
    _snapshot = _snapshot.inState(ConnectionState.waiting);
  }
}
