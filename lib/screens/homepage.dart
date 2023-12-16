import 'dart:convert';

import 'package:currency_converter/constants/colors.dart';
import 'package:currency_converter/models/currencydata.dart';
import 'package:currency_converter/widgets/currencyBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyData currencyData = CurrencyData();
  late Map<String, double> currencyRates = {};
  void initState() {
    Future.delayed(Duration.zero, () {
      getCurrencyData();
    });
    super.initState();
  }

  Future<void> getCurrencyData({String? currency = 'PKR'}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    http.Response response = await http
        .get(Uri.parse("https://open.er-api.com/v6/latest/$currency"));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> ratesData = data['rates'];
      currencyRates = Map<String, double>.from(ratesData);
    } else if (currencyData.result == "error") {
      _showToast("${currencyData.result}");
    } else {
      throw Exception('Failed to load currency rates');
    }
    setState(() {
      currencyData = CurrencyData.fromJson(jsonDecode(response.body));
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/frame.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Text("Currency Converter",
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                _showTextField(),
                Padding(
                    padding: const EdgeInsets.only(top: 48, bottom: 9),
                    child: Text("Current Currency",
                        style: Theme.of(context).textTheme.bodySmall)),
                TextButton(
                    onPressed: () {},
                    child: Text(currencyData.baseCode ?? "-:-",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 40))),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 25),
                  child: Container(
                    width: 109,
                    height: 22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: darkgrey),
                    child: Center(
                      child: currencyData.timeLastUpdateUtc == null
                          ? const Text("--/--/--")
                          : Text(
                              currencyData.timeLastUpdateUtc!.substring(0, 16),
                              style: Theme.of(context).textTheme.displaySmall),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: lightBlue,
                        thickness: 1,
                        height: 17,
                      ),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final currency = currencyRates.keys.elementAt(index);
                        final rate = currencyRates[currency];
                        return CurrencyBar(
                          titlekey: currency,
                          value: rate ?? 0.0,
                          callback: () {},
                        );
                      },
                      itemCount: currencyRates.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTextField() {
    String getcurrency;
    return TextField(
      cursorColor: white,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: "Type your currency",
      ),
      onSubmitted: (value) {
        getcurrency = value;
        getCurrencyData(currency: getcurrency.toUpperCase());
      },
    );
  }

  _showToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: white,
        fontSize: 16.0);
  }
}
