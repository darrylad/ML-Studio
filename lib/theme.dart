import 'package:flutter/material.dart';

ThemeData theme() {
  final baseTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    scaffoldBackgroundColor: const Color(0xffF1F1F1),
    fontFamily: 'Inter',
    useMaterial3: false,
  );

  return baseTheme.copyWith(
    textTheme: adjustTextTheme(baseTheme.textTheme),
  );
}

class Col {
  static const Color blue = Color(0xff4479f5);
  static const Color green = Color(0xff1c8955);
  static const Color darkBlue = Color(0xff3361CD);
}

FontWeight bolder(FontWeight? weight) {
  const mapping = {
    FontWeight.w100: FontWeight.w200,
    FontWeight.w200: FontWeight.w300,
    FontWeight.w300: FontWeight.w400,
    FontWeight.w400: FontWeight.w500,
    FontWeight.w500: FontWeight.w600,
    FontWeight.w600: FontWeight.w700,
    FontWeight.w700: FontWeight.w800,
    FontWeight.w800: FontWeight.w900,
    FontWeight.w900: FontWeight.w900,
  };
  return mapping[weight] ?? FontWeight.w900;
}

TextTheme adjustTextTheme(TextTheme base) {
  return TextTheme(
    displayLarge: base.displayLarge
        ?.copyWith(fontWeight: bolder(base.displayLarge?.fontWeight)),
    displayMedium: base.displayMedium
        ?.copyWith(fontWeight: bolder(base.displayMedium?.fontWeight)),
    displaySmall: base.displaySmall
        ?.copyWith(fontWeight: bolder(base.displaySmall?.fontWeight)),
    headlineLarge: base.headlineLarge
        ?.copyWith(fontWeight: bolder(base.headlineLarge?.fontWeight)),
    headlineMedium: base.headlineMedium
        ?.copyWith(fontWeight: bolder(base.headlineMedium?.fontWeight)),
    headlineSmall: base.headlineSmall
        ?.copyWith(fontWeight: bolder(base.headlineSmall?.fontWeight)),
    titleLarge: base.titleLarge
        ?.copyWith(fontWeight: bolder(base.titleLarge?.fontWeight)),
    titleMedium: base.titleMedium
        ?.copyWith(fontWeight: bolder(base.titleMedium?.fontWeight)),
    titleSmall: base.titleSmall
        ?.copyWith(fontWeight: bolder(base.titleSmall?.fontWeight)),
    bodyLarge: base.bodyLarge
        ?.copyWith(fontWeight: bolder(base.bodyLarge?.fontWeight)),
    bodyMedium: base.bodyMedium
        ?.copyWith(fontWeight: bolder(base.bodyMedium?.fontWeight)),
    bodySmall: base.bodySmall
        ?.copyWith(fontWeight: bolder(base.bodySmall?.fontWeight)),
    labelLarge: base.labelLarge
        ?.copyWith(fontWeight: bolder(base.labelLarge?.fontWeight)),
    labelMedium: base.labelMedium
        ?.copyWith(fontWeight: bolder(base.labelMedium?.fontWeight)),
    labelSmall: base.labelSmall
        ?.copyWith(fontWeight: bolder(base.labelSmall?.fontWeight)),
  );
}
