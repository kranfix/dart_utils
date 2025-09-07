import 'package:meta/meta.dart';

mixin UnmodifiableIndexedValue<E> on List<E> {
  @override
  @nonVirtual
  void operator []=(covariant Never index, covariant Never value) {
    throw UnsupportedError(
      '[UnmodifiableIndexedValue] $runtimeType can not support '
      'value updates by index',
    );
  }
}
