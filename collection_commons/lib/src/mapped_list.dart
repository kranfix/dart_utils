import 'dart:collection';

import 'package:collection_commons/src/readonly_list/unmodifiable_indexed_value.dart';

/// A read-only list that provides a view of another list,
/// applying a mapping function to each element.
///
/// This class is useful for creating a list of a different type
/// from an existing list without copying the entire list. It's an
/// abstract class, and you can create an instance using the
/// factory constructor.
///
/// The list is backed by a [_source] list. Any changes to the
/// [_source] list will be reflected in this list.
abstract class MappedList<T, U> with ListMixin<T>, UnmodifiableIndexedValue<T> {
  /// Creates a new `MappedList` with a given source list.
  MappedList(List<U> source) : _source = source;

  /// A factory constructor to create a `MappedList` instance.
  ///
  /// This is the preferred way to instantiate a `MappedList`.
  /// It takes a [source] list and a [mapper] function.
  factory MappedList.withMapper(List<U> source, T Function(U) mapper) =
      _MappedList;

  /// The underlying source list that this list provides a view of.
  final List<U> _source;

  @override
  int get length => _source.length;

  /// Returns the element at the given [index].
  ///
  /// This method applies the mapping function to the element from the
  /// source list.
  @override
  T operator [](int index);

  /// Throws an [UnsupportedError] because resizing the list is not supported.
  @override
  set length(int newLength) {
    throw UnsupportedError('Assiging is not supported');
  }
}

/// An internal implementation of `MappedList`.
///
/// This class handles the actual mapping of elements.
class _MappedList<T, U> extends MappedList<T, U> {
  /// Creates an internal `_MappedList` instance.
  ///
  /// Takes the [source] list and the [mapper] function.
  _MappedList(super.source, this.mapper) : super();

  /// The function used to map elements from type `U` to type `T`.
  final T Function(U) mapper;

  @override
  T operator [](int index) => mapper(_source[index]);
}
