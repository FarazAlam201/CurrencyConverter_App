import 'package:currency_converter/constants/colors.dart';
import 'package:flutter/material.dart';

class CurrencyBar extends StatefulWidget {
  String titlekey;
  var value;
  VoidCallback? callback;
  CurrencyBar({
    super.key,
    required this.titlekey,
    required this.value,
    required this.callback,
  });

  @override
  State<CurrencyBar> createState() => _CurrencyBarState();
}

class _CurrencyBarState extends State<CurrencyBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: ListTile(
        tileColor: transparent,
        leading: Image.asset("assets/images/coins.png"),
        title: Text(
          widget.titlekey,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: Text(
          widget.value.toStringAsFixed(2),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
