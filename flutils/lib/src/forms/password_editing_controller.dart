import 'package:flutter/material.dart';

class PasswordEditingController extends TextEditingController {
  PasswordEditingController({String text, bool showText = false})
      : _wasSelected = false,
        _isEdited = false,
        _showText = showText ?? false,
        super(text: text);

  bool _showText;
  bool get showText => _showText;
  bool get obscureText => !_showText;

  bool _wasSelected;
  bool get wasSelected => _wasSelected;
  bool get wasNotSelected => !_wasSelected;

  bool _isEdited;
  bool get isEdited => _isEdited;
  bool get isNotEdited => !_isEdited;

  void toggleShowText() {
    _showText = !_showText;
    notifyListeners();
  }

  @override
  set value(TextEditingValue newValue) {
    if (wasNotSelected) {
      _wasSelected = true;
    } else if (newValue.text.isNotEmpty) {
      _isEdited = true;
    }

    super.value = newValue;
  }
}
