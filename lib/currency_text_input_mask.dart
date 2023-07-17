library currency_text_input_mask;
import 'package:flutter/material.dart';

class CurrencyTextInputMaskController extends TextEditingController {
  String _decimalSeparator = ',';
  String _thousandSeparator = '.';
  String _rightSymbol = '';
  String _leftSymbol = '';
  int _precision = 2;
  double _initialValue = 0.0;

  CurrencyTextInputMaskController() {
    _validateConfig();
    addListener(() {
      updateValue(numberValue);
      afterChange(text, numberValue);
    });
  }

  void initialValue(double value) {
    _initialValue = value;
    updateValue(_initialValue);
  }

  void decimalSeparator(String value) {
    _decimalSeparator = value;
  }

  void thousandSeparator(String value) {
    _thousandSeparator = value;
  }

  void rightSymbol(String value) {
    _rightSymbol = " $value";
  }

  void leftSymbol(String value) {
    _leftSymbol = "$value ";
  }

  void precision(int value) {
    _precision = value;
  }

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = _applyMask(valueToUse);

    if (_rightSymbol.isNotEmpty) {
      masked += _rightSymbol;
    }

    if (_leftSymbol.isNotEmpty) {
      masked = _leftSymbol + masked;
    }

    if (masked != text) {
      text = masked;

      var cursorPosition = super.text.length - _rightSymbol.length;
      selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    if (text == _rightSymbol || text == _leftSymbol) {
      return 0.0;
    }
    List<String> parts = _getOnlyNumbers(text).split('').toList(growable: true);
    int index = parts.length - _precision;

    if (index >= 0) {
      parts.insert(index, '.');
    }
    return double.parse(parts.join(''));
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(_rightSymbol).isNotEmpty;

    if (rightSymbolHasNumbers) {
      throw ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = RegExp(r'[^0-9]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(_precision)
        .replaceAll(_decimalSeparator, '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(_precision, _decimalSeparator);

    for (var i = _precision + 4; textRepresentation.length > i; i += 4) {
      textRepresentation.insert(i, _thousandSeparator);
    }

    return textRepresentation.reversed.join('');
  }
}

