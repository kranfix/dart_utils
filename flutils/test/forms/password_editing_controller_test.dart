import 'package:flutter_test/flutter_test.dart';
import 'package:flutils/flutils.dart';

void main() {
  group('Selection and Edition', () {
    final controller = PasswordEditingController();

    test('verifies initial conditions', () {
      expect(controller.text, equals(''));
      expect(controller.wasSelected, equals(false));
      expect(controller.wasNotSelected, equals(true));
      expect(controller.isEdited, equals(false));
      expect(controller.wasNotSelected, equals(true));
    });

    test('selects for first time', () {
      controller.text = '';
      expect(controller.text, equals(''));
      expect(controller.wasSelected, equals(true));
      expect(controller.wasNotSelected, equals(false));
      expect(controller.isEdited, equals(false));
      expect(controller.isNotEdited, equals(true));
    });

    test('edits for first time', () {
      controller.text = 'a';
      expect(controller.text, equals('a'));
      expect(controller.wasSelected, equals(true));
      expect(controller.wasNotSelected, equals(false));
      expect(controller.isEdited, equals(true));
      expect(controller.isNotEdited, equals(false));
    });
  });

  group('Show or obscure text', () {
    final controller = PasswordEditingController();
    test('verifies initial showText state', () {
      expect(controller.showText, equals(false));
      expect(controller.obscureText, equals(true));
    });

    test('toggle showText', () {
      controller.toggleShowText();
      expect(controller.showText, equals(true));
      expect(controller.obscureText, equals(false));

      controller.toggleShowText();
      expect(controller.showText, equals(false));
      expect(controller.obscureText, equals(true));
    });
  });
}
