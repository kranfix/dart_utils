import 'dart:collection';

import 'package:collection_commons/src/readonly_list/unmodificable_length_list.dart';
import 'package:meta/meta.dart';

/// A mutable view of a portion of another list.
///
/// Unlike [Slice], which is an immutable view, `SliceMut` allows you to
/// modify the underlying list by assigning new values to its elements.
/// All mutations are applied directly to the original list.
extension type SliceMut<E>._(_SliceInner<E> _slice) implements _SliceInner<E> {
  /// Creates a new mutable slice from an iterable.
  ///
  /// This factory constructor creates a new list from the `source` and
  /// then wraps it in a `SliceMut`. Since it creates a copy, changes
  /// will not affect the original source, but will be local to this slice.
  SliceMut.from(Iterable<E> source) : this._(_SliceInner._([...source]));

  /// Creates a new mutable slice that directly references a list.
  ///
  /// This constructor is "unsafe" because it does not create a copy of
  /// the source list. Any changes to this slice will directly modify the
  /// provided `source` list. Use with caution.
  SliceMut.unsafeFrom(List<E> source) : this._(_SliceInner._(source));

  Slice<E> asRef() => Slice._(_slice);

  (SliceMut<E>, SliceMut<E>) splitAt(int splitIndex) =>
      _slice._splitAt(splitIndex, SliceMut<E>._);
}

/// A read-only list that represents a portion (a "slice") of another list.
///
/// This class provides a window into a `_root` list without creating a new
/// copy of the data. It is highly efficient for accessing sub-ranges of a list.
@immutable
extension type const Slice<E>._(_SliceInner<E> _slice)
    implements _SliceInner<E> {
  /// Creates a new slice from an iterable.
  ///
  /// This factory constructor creates a new list from the `source` and
  /// then wraps it in a `Slice`. Since it creates a copy, changes
  /// will not affect the original source.
  Slice.from(Iterable<E> source) : this._(_SliceInner._([...source]));

  /// Creates a new slice that directly references a list.
  ///
  /// This constructor is "unsafe" because it does not create a copy of
  /// the source list. Use with caution.
  Slice.unsafeFrom(List<E> source) : this._(_SliceInner._(source));

  /// Throws an [UnsupportedError] because [Slice] is an immutable view.
  ///
  /// This method is overridden to prevent any modification attempts.
  void operator []=(Never index, Never value) {
    throw UnsupportedError(
      '[Slice] $runtimeType can not support value updates by index',
    );
  }

  @Deprecated('message')
  @internal
  Never sort(Never compare) {
    throw UnsupportedError('[Slice] $runtimeType can not be sorted');
  }

  Slice<E> slice(int start, {int? end, int? len}) {
    return Slice._(_slice._slice(start, end: end, len: len));
  }

  (Slice<E>, Slice<E>) splitAt(int splitIndex) =>
      _slice._splitAt(splitIndex, Slice<E>._);
}

class _SliceInner<E> extends ListMixin<E> with UnmodifiableLengthList<E> {
  const _SliceInner._(this._root, [int start = 0, int? end])
      : _start = start,
        length = (end ?? _root.length) - start;

  /// The underlying root list that this slice provides a view of.
  final List<E> _root;

  /// The starting index of the slice within the `_root` list.
  final int _start;

  @override
  final int length;

  /// Returns the first element in the slice.
  @override
  E get first => _root[_start];

  /// Returns the last element in the slice.
  @override
  E get last => _root[_start + length - 1];

  /// Returns the element at the given `index` within the slice.
  ///
  /// The index is relative to the start of the slice.
  @override
  E operator [](int index) => _root[_start + index];

  // ************************ Mutable section ************************/
  @override
  void operator []=(int index, E value) {
    IndexError.check(index, length);
    _root[_start + index] = value;
  }

  // ******************* Mutable/Immutable section *******************/

  /// Creates a new `Slice` that represents a sub-range of this slice.
  ///
  /// This method is designed to flatten the reference chain, ensuring that
  /// a new slice always refers directly to the original `_root` list,
  /// regardless of how many times `slice()` is called. This prevents nested
  /// `Slice` objects and keeps the memory footprint low.
  ///
  /// You must provide either an `end` or a `length`, but not both.
  ///
  /// - `start`: The starting index of the new slice, relative to the
  ///            current slice.
  /// - `end`: (Optional) The exclusive end index of the new slice, relative
  ///          to the current slice.
  /// - `length`: (Optional) The length of the new slice.
  _SliceInner<E> _slice(int start, {int? end, int? len}) {
    assert(
      end == null || len == null,
      'end and len can not be non-null at the same time',
    );
    RangeError.checkValueInInterval(start, 0, length, 'start');
    final newStart = _start + start;

    if (end != null) {
      RangeError.checkValueInInterval(end, newStart, length, 'end');
      final newEnd = this._start + end;
      return _SliceInner._(_root, newStart, newEnd);
    }

    if (len != null) {
      final maxLen = length - start;
      RangeError.checkValueInInterval(len, 0, maxLen, 'len');
      final newEnd = newStart + len;
      return _SliceInner._(_root, newStart, newEnd);
    }

    return _SliceInner._(_root, newStart, this._start + this.length);
  }

  (T, T) _splitAt<T>(
    int splitIndex,
    T Function(_SliceInner<E>) map,
  ) {
    RangeError.checkValueInInterval(splitIndex, 0, length, 'splitIndex');
    return (
      map(_SliceInner._(_root, _start, _start + splitIndex)),
      map(_SliceInner._(_root, _start + splitIndex, _start + length)),
    );
  }
}
