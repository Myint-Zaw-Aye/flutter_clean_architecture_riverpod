import 'package:flutter/material.dart';

abstract class AppColors {
  // static const Color primaryColor = Color.fromARGB(255, 255, 212, 83);
    static const Color primaryColor = Color.fromARGB(255, 42, 52, 55);

  static const Color secondaryColor = Color(0xFF5777F9);
  static const Color pageBackground = Color(0xFFFAFBFE);
  static const Color lightBlueColor2 = Color(0xffe8ecff);
  static const Color whiteColor = Color(0xffffffff);
  static const controlBarColor = Color.fromARGB(255, 42, 42, 42);
  static const thirdColor = Color.fromARGB(255, 196, 142, 8);


  static const Color statusBarColor = Color(0xFF38686A);
  static const Color appBarColor = Color(0xFF38686A);
  static const Color appBarIconColor = Color(0xFFFFFFFF);
  static const Color appBarTextColor = Color(0xFFFFFFFF);

  static const Color centerTextColor = Colors.grey;
  static const MaterialColor colorPrimarySwatch = Colors.cyan;
  static const Color colorPrimary = Color(0xFF38686A);
  static const Color colorAccent = Color(0xFF38686A);
  static const Color colorLightGreen = Color(0xFF00EFA7);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color errorColor = Color(0xFFAB0B0B);
  static const Color colorDark = Color(0xFF323232);

  // Dark theme colors
  static const Color canvasColor = Color(0xFFFAFAFA);
  static const Color canvasColorDark = Color(0xFF212121);

  static const Color buttonBgColor = colorPrimary;
  static const Color disabledButtonBgColor = Color(0xFFBFBFC0);
  static const Color defaultRippleColor = Color(0x0338686A);

  static const Color textColorPrimary = Color(0xFF323232);
  static const Color textColorSecondary = Color(0xFF9FA4B0);
  static const Color textColorTag = colorPrimary;
  static const Color textColorGreyLight = Color(0xFFABABAB);
  static const Color textColorGreyDark = Color(0xFF979797);
  static const Color textColorBlueGreyDark = Color(0xFF939699);
  static const Color textColorCyan = Color(0xFF38686A);
  static const Color textColorWhite = Color(0xFFFFFFFF);
  static Color searchFieldTextColor = const Color(0xFF323232).withOpacity(0.5);

  static const Color iconColorDefault = Colors.grey;

  static Color barrierColor = const Color(0xFF000000).withOpacity(0.5);

  static Color timelineDividerColor = const Color(0x5438686A);

  static const Color gradientStartColor = Colors.black87;
  static const Color gradientEndColor = Colors.transparent;
  static const Color silverAppBarOverlayColor = Color(0x80323232);

  static const Color switchActiveColor = colorPrimary;
  static const Color switchInactiveColor = Color(0xFFABABAB);

  static const Color boxColor = Color.fromARGB(255, 45, 59, 45);
  static const Color textColor = Color(0xff6E7683);

  static const Color borderColor = Color(0xff252B39);
  static const Color primaryButtonColor = Color(0xffFCD434);
  static const Color secondaryButtonColor = Color(0xff333B48);

  static const Color positiveColor = Color.fromARGB(255, 23, 219, 29);
  static const Color negitiveColor = Color(0xFFAB0B0B);

  static Color primary = HexColor("05101A");
  static Color lightGray = HexColor("D3D3D3");
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
