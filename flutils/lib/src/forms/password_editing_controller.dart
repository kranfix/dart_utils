import 'package:flutter/material.dart';

/// {@template flutils_forms_PasswordEditingController}
/// An extension of [TextEditingController] for adding controls for obscuring
/// text and validating if the textfield was edited
/// {@endtemplate}
class PasswordEditingController extends TextEditingController {
  /// {@macro flutils_forms_PasswordEditingController}
  PasswordEditingController({super.text, bool showText = false})
      : _wasSelected = false,
        _isEdited = false,
        _showText = showText;

  bool _showText;

  /// Indicates if the text must be shown
  bool get showText => _showText;

  /// Indicates if the text must be obscured
  bool get obscureText => !_showText;

  bool _wasSelected;

  ///
  bool get wasSelected => _wasSelected;

  ///
  bool get wasNotSelected => !_wasSelected;

  bool _isEdited;

  /// Indicates if the textfield is edited
  bool get isEdited => _isEdited;

  /// Indicates if the textfield is not edited
  bool get isNotEdited => !_isEdited;

  /// Change between showing and obscuring text
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
