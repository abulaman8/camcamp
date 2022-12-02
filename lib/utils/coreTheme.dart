import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreTheme {
  static const maroon = Color(0xff7b242c);
  static const beige = Color(0xffd5a54e);
  static const red = Color(0xffda2a27);
  static const grey = Color(0xff2a211f);
  static  const cream = Color(0xfff9f6f5);

  
  

  // 1
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

 

  // 2
  static ThemeData dark() {
    return ThemeData(
      backgroundColor: maroon,
      brightness: Brightness.dark,
      // ignore: prefer_const_constructors
      scaffoldBackgroundColor: grey,
      appBarTheme: AppBarTheme(

        foregroundColor: Colors.white,
        backgroundColor: maroon,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: maroon,
          onPrimary: Colors.white,
        )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: maroon,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: beige,
      ),
      textTheme: darkTextTheme,
    );
  }
}