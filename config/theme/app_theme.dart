import 'package:flutter/material.dart';

class AppTheme{

  ThemeData getTheme()=>ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF0068FB),
    brightness: Brightness.dark,

  );
}