import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/localization_imports.dart';

abstract class AppLocalization extends BaseLocalization {
  AppLocalization({
    required super.code,
    required super.name,
    super.country,
  });

  static AppLocalization currentLocalization() =>
      Localization.currentLocalization as AppLocalization;

  String get retry;

  String get ok;

  String get english;

  String get usernameLogin;

  String get password;

  String get loginUserNameError;

  String get passwordError;

  String get login;

  String get forgetPassword;

  String get invalidCredentials;

  String get createNewAccount;

  String get selectYourLanguage;

  String get loginWithFaceBook;

  String get signUp;

  String get mobileEmail;

  String get fullName;

  String get usernameSignUp;

  String get mobileEmailError;

  String get signUpUserNameError;

  String get or;

  String get fullNameError;

  String get signTopText;

  String get privacyPolicyText;

  String get privacyPolicyTextHighLight;

  String get haveAnAccount;

  String get alreadyHaveAccount;
}
