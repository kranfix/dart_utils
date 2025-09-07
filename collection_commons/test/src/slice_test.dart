import 'package:collection_commons/collection_commons.dart';
import 'package:test/test.dart';

void main() {
  test('slice ...', () {
    final source = Slice.from(const <int>[1, 0, 2, 9, 3, 8, 4, 7, 5, 6]);

    expect(source.length, 10);
    expect(source.first, 1);
    expect(source.last, 6);

    final slice1 = source.slice(0, end: 5);
    compareSlice(slice1, [1, 0, 2, 9, 3]);

    compareSlice(source.slice(5, end: 9), [8, 4, 7, 5]);
    compareSlice(source.slice(5, len: 4), [8, 4, 7, 5]);

    final slice2 = source.slice(5);
    compareSlice(slice2, [8, 4, 7, 5, 6]);
  });

  test('sliceMut', () {
    final source = SliceMut.unsafeFrom(<int>[1, 0, 2, 9, 3, 8, 4, 7, 5, 6]);

    final (slice1, slice2) = source.splitAt(5);
    compareSlice(slice1.asRef(), [1, 0, 2, 9, 3]);
    compareSlice(slice2.asRef(), [8, 4, 7, 5, 6]);

    slice1.sort();
    slice2.sort();
    compareSlice(slice1.asRef(), [0, 1, 2, 3, 9]);
    compareSlice(slice2.asRef(), [4, 5, 6, 7, 8]);
  });
}

void compareSlice<E>(Slice<E> slice, List<E> list) {
  expect(slice.length, list.length);
  expect(slice.first, list.first);
  expect(slice.last, list.last);
  expect(slice, equals(list));
}
