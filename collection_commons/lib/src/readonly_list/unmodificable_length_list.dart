import 'package:meta/meta.dart';

mixin UnmodifiableLengthList<E> on List<E> {
  @override
  @protected
  @visibleForTesting
  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of a $runtimeType');
  }

  @override
  @nonVirtual
  Never setAll(covariant Never index, covariant Never iterable) {
    throw UnsupportedError('Cannot modify a $runtimeType');
  }

  @override
  @nonVirtual
  Never add(covariant Never value) {
    throw UnsupportedError('Cannot add to a $runtimeType');
  }

  @override
  @nonVirtual
  Never insert(covariant Never index, covariant Never element) {
    throw UnsupportedError('Cannot add to a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never insertAll(covariant Never at, covariant Never iterable) {
    throw UnsupportedError('Cannot add to a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never addAll(covariant Never iterable) {
    throw UnsupportedError('Cannot add to a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never remove(covariant Never element) {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never removeWhere(covariant Never test) {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never retainWhere(covariant Never test) {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never clear() {
    throw UnsupportedError('Cannot clear a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never removeAt(covariant Never index) {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never removeLast() {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never setRange(
    int start,
    int end,
    Iterable<E> iterable, [
    int skipCount = 0,
  ]) {
    throw UnsupportedError('Cannot modify a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never removeRange(int start, int end) {
    throw UnsupportedError('Cannot remove from a $runtimeType');
  }

  /// This operation is not supported by a Slice.
  @override
  @nonVirtual
  Never fillRange(int start, int end, [E? fillValue]) {
    throw UnsupportedError('Cannot modify a $runtimeType');
  }
}
