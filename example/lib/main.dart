import 'package:currency_text_input_mask/currency_text_input_mask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo',
        key: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final  _controller =
      CurrencyTextInputMaskController();

  void _baseSettingsController(BuildContext context) {
    final locale = Localizations.localeOf(context);
    var currencySettings =
    NumberFormat.simpleCurrency(locale: locale.languageCode);
    _controller.decimalSeparator(currencySettings.symbols.DECIMAL_SEP);
    _controller.thousandSeparator(currencySettings.symbols.GROUP_SEP);
    _controller.leftSymbol(currencySettings.currencySymbol);
  }

  @override
  Widget build(BuildContext context) {
    _baseSettingsController(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: TextField(
            controller: _controller,
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
