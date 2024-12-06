import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors.dart';
import '../user/user_service.dart';

class AppTheme {
  AppTheme(this._userService);

  final UserService _userService;

  late Brightness brightness;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryBlue1,
      primaryColorDark: AppColors.primaryBlue1,
      primaryColorLight: AppColors.primaryBlue1,
      highlightColor: AppColors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.primaryBlue1,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryBlue1,
      primaryColorDark: AppColors.primaryBlue1,
      primaryColorLight: AppColors.primaryBlue1,
      highlightColor: AppColors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.primaryBlue1,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
    );
  }

  ThemeData get theme {
    AppColors.isLightTheme = _userService.isLightTheme;
    return AppColors.isLightTheme ? lightTheme : darkTheme;
  }

  bool get isLight {
    AppColors.isLightTheme = _userService.isLightTheme;
    return AppColors.isLightTheme;
  }

  bool changeTheme() {
    _userService.setThemeToLight(setToLightTheme: !isLight);
    AppColors.isLightTheme = isLight;
    return AppColors.isLightTheme;
  }
}
