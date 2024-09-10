import 'package:flutter/material.dart';
import 'package:neon_david_cursor/models/color_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static const String colorKey = 'color';

  static void saveColor(Color color) async {
    final String colorHex = color.value.toRadixString(16).padLeft(8, '0');
    await _sharedPrefs?.setString(colorKey, colorHex);
  }

  static Color getColor() {
    String? colorHex = _sharedPrefs?.getString(colorKey);
    if (colorHex != null) {
      print('colorHex: $colorHex');
      return Color(int.parse(colorHex, radix: 16));
    }

    return ColorData.defaultColor;
  }
}
