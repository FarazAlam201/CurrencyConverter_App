import 'package:currency_converter/constants/colors.dart';
import 'package:currency_converter/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: navyblue,
          primaryColorDark: navyblue,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.urbanist(
                fontSize: 24, color: white, fontWeight: FontWeight.w600),
            displaySmall: GoogleFonts.urbanist(
                fontSize: 12, color: white, fontWeight: FontWeight.w500),
            bodySmall: GoogleFonts.urbanist(
                fontSize: 14, color: white, fontWeight: FontWeight.w600),
            bodyMedium: GoogleFonts.urbanist(
                fontSize: 15, color: white, fontWeight: FontWeight.w700),
            bodyLarge: GoogleFonts.urbanist(
                fontSize: 18, color: white, fontWeight: FontWeight.w700),
          ),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: lightBlue,
              filled: true,
              hintStyle: GoogleFonts.urbanist(
                  fontSize: 14, color: white, fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none))),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
