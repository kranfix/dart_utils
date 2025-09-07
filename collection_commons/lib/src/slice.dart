import 'dart:collection';

import 'package:collection_commons/src/readonly_list/unmodificable_length_list.dart';

/// A read-only list that represents a portion (a "slice") of another list.
///
/// This class provides a window into a `_root` list without creating a new
/// copy of the data. It is highly efficient for accessing sub-ranges of a list.
///
/// The `Slice` is backed by a root list, and any changes made to the `Slice`
/// (via the `[]=` operator) will modify the underlying `_root` list.
class Slice<E> extends ListMixin<E> with UnmodifiableLengthList<E> {
  /// Internal constructor for creating a slice.
  ///
  /// This constructor is used to create a new `Slice` that refers to a
  /// specific range of the [_root] list. The `_start` and `length` define
  /// the boundaries of the slice.
  Slice._(this._root, [int start = 0, int? end])
      : _start = start,
        length = (end ?? _root.length) - start;

  /// Creates a `Slice` from an `Iterable`.
  ///
  /// This factory constructor creates a new list from the `source` and
  /// then wraps it in a `Slice`.
  factory Slice.from(Iterable<E> source) => Slice._([...source]);

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

  /// Sets the value at the given `index` within the slice.
  ///
  /// The change is applied directly to the underlying `_root` list.
  @override
  void operator []=(int index, E value) {
    IndexError.check(index, length);
    _root[_start + index] = value;
  }

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
  Slice<E> slice(int start, {int? end, int? length}) {
    if (start < 0) {
      throw RangeError.range(start, 0, this.length, 'start');
    }

    if (end != null && end < 0) {
      throw RangeError.range(end, 0, this.length, 'end');
    }

    if (length != null && length < 0) {
      throw RangeError.range(length, 0, this.length, 'length');
    }

    final newStart = this._start + start;
    if (end != null) {
      return Slice._(_root, newStart, this._start + end);
    }

    if (length != null) {
      final newEnd = newStart + length;
      return Slice._(_root, newStart, newEnd);
    }

    return Slice._(_root, newStart, this._start + this.length);
  }
}
