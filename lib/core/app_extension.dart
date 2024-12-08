import 'package:flutter/material.dart';

import '../localization/app_localization.dart';
import 'colors.dart';
import 'enum.dart';
import 'images.dart';

extension ImageIcon on TextFieldSuffixIconType {
  static String _imageIcon(TextFieldSuffixIconType val) {
    switch (val) {
      case TextFieldSuffixIconType.cancel:
        return Images.cancel;
      case TextFieldSuffixIconType.showObscureText:
        return Images.showObscureText;
      case TextFieldSuffixIconType.hideObscureText:
        return Images.hideObscureText;
    }
  }

  String get imageIcon => _imageIcon(this);
}

extension AppLoaderThemeColor on AppLoaderTheme {
  Color get backgroundColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.primaryBlue1;
      case AppLoaderTheme.dark:
        return AppColors.white;
    }
  }

  Color get valueColor {
    switch (this) {
      case AppLoaderTheme.light:
        return AppColors.white;
      case AppLoaderTheme.dark:
        return AppColors.primaryBlue1;
    }
  }
}

extension SharedPreferenceStoreExtractor on SharedPreferenceStore {
  String get preferenceKey => name;

  Type get getRuntimeType {
    switch (this) {
      case SharedPreferenceStore.IS_USER_LOGGED_IN:
        return bool;
      case SharedPreferenceStore.IS_LIGHT_THEME:
        return bool;
      case SharedPreferenceStore.SERVER_TOKEN:
        return String;
      case SharedPreferenceStore.LANGUAGE_CODE:
        return String;
      case SharedPreferenceStore.USER_DETAILS:
        return String;
    }
  }
}

extension LoginTextFieldEnumExtention on LoginTextFieldEnum {
  String get title {
    switch (this) {
      case LoginTextFieldEnum.username:
        return AppLocalization.currentLocalization().usernameLogin;
      case LoginTextFieldEnum.password:
        return AppLocalization.currentLocalization().password;
    }
  }
}

extension SignUpTextFieldEnumExtention on SignUpTextFieldEnum {
  String get title {
    switch (this) {
      case SignUpTextFieldEnum.mobileEmail:
        return AppLocalization.currentLocalization().mobileEmail;
      case SignUpTextFieldEnum.fullName:
        return AppLocalization.currentLocalization().fullName;
      case SignUpTextFieldEnum.username:
        return AppLocalization.currentLocalization().usernameSignUp;
      case SignUpTextFieldEnum.password:
        return AppLocalization.currentLocalization().password;
    }
  }
}
