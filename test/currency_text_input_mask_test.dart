import 'package:currency_text_input_mask/currency_text_input_mask.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds 0 inputs for controller', () {
    final controller = CurrencyTextInputMaskController();
    controller.text = "0";
    expect(controller.text, "");
    expect(controller.doubleValue, 0.0);
  });

  test('add inputs non zero for controller', () {
    final controller = CurrencyTextInputMaskController();

    controller.text = "1244";
    expect(controller.text, "R\$ 12,44");
    expect(controller.doubleValue, 12.44);
  });

  test('change symbols constructor', () {
    final controller = CurrencyTextInputMaskController(
        rightSymbol: "RR", decimalSymbol: ".", thousandSymbol: ",");

    expect(controller.thousandSymbol, ",");
    expect(controller.leftSymbol, "RR");
    expect(controller.decimalSymbol, ".");
  });
}
