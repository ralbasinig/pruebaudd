import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
  colors: const FlexSchemeColor( // Custom
    primary: Color(0xff3675ef),
    primaryContainer: Color(0xff000000),
    primaryLightRef: Color(0xff3675ef),
    secondary: Color(0xffde5454),
    secondaryContainer: Color(0xffd0e4ff),
    secondaryLightRef: Color(0xffde5454),
    tertiary: Color(0xff3675ef),
    tertiaryContainer: Color(0xffd0e4ff),
    tertiaryLightRef: Color(0xff3675ef),
    appBarColor: Color(0xffd0e4ff),
    error: Color(0xfffa2e2e),
    errorContainer: Color(0xfffed5d5),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
  colors: const FlexSchemeColor( // Custom
    primary: Color(0xff9fc9ff),
    primaryContainer: Color(0xff00325b),
    primaryLightRef: Color(0xff3675ef),
    secondary: Color(0xffffb59d),
    secondaryContainer: Color(0xff872100),
    secondaryLightRef: Color(0xffde5454),
    tertiary: Color(0xff86d2e1),
    tertiaryContainer: Color(0xff004e59),
    tertiaryLightRef: Color(0xff3675ef),
    appBarColor: Color(0xffd0e4ff),
    error: Color(0xffffb4ab),
    errorContainer: Color(0xff93000a),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // ignore: prefer_typing_uninitialized_variables
  static var lightTheme;

  // ignore: prefer_typing_uninitialized_variables
  static var darkTheme;
}
