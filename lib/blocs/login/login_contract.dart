import 'package:flutter/material.dart' as material;
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../core/enum.dart';
import '../../services/hive/model/user_account_hive.dart';

part 'login_contract.g.dart';

abstract class LoginData implements Built<LoginData, LoginDataBuilder> {
  factory LoginData([void Function(LoginDataBuilder) updates]) = _$LoginData;

  LoginData._();

  ScreenState get state;

  String? get errorMessage;

  String? get useNameErrorMessage;

  String? get passwordErrorMessage;

  material.TextEditingController get usernameController;

  material.TextEditingController get passwordController;

  bool? get isLoginButtonLoading;

  List<UserAccountHive> get userAccountsList;

  String? get selectedLanguageCode;
}

abstract class LoginEvent {}

class InitLoginEvent extends LoginEvent {}

class TextFieldChangedEvent extends LoginEvent {
  final LoginTextFieldEnum loginTextFieldEnum;
  final String text;

  TextFieldChangedEvent({required this.loginTextFieldEnum, required this.text});
}

class LoginButtonTapEvent extends LoginEvent {}

class SelectLanguageTapEvent extends LoginEvent {}

class LanguageTapEvent extends LoginEvent {
  final String languageCode;
  final Localization localization;

  LanguageTapEvent({required this.languageCode, required this.localization});
}

class CreteAccountTapEvent extends LoginEvent {}

class UpdateLoginState extends LoginEvent {
  final LoginData state;

  UpdateLoginState(this.state);
}
