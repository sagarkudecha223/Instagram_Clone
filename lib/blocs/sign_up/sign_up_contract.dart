import 'package:flutter/material.dart' as material;
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

import '../../core/enum.dart';

part 'sign_up_contract.g.dart';

abstract class SignUpData implements Built<SignUpData, SignUpDataBuilder> {
  factory SignUpData([void Function(SignUpDataBuilder) updates]) = _$SignUpData;

  SignUpData._();

  ScreenState get state;

  material.TextEditingController get mobileEmailController;

  material.TextEditingController get fullNameController;

  material.TextEditingController get usernameController;

  material.TextEditingController get passwordController;

  String? get mobileEmailErrorMessage;

  String? get fullNameErrorMessage;

  String? get useNameErrorMessage;

  String? get passwordErrorMessage;

  bool? get isSignUpButtonLoading;

  bool? get isFacebookButtonLoading;

  String? get errorMessage;
}

abstract class SignUpEvent {}

class InitSignUpEvent extends SignUpEvent {}

class SignUpButtonTapEvent extends SignUpEvent {}

class TextFieldChangedEvent extends SignUpEvent {
  final SignUpTextFieldEnum signUpTextFieldEnum;
  final String text;

  TextFieldChangedEvent({required this.signUpTextFieldEnum, required this.text});
}

class UpdateSignUpState extends SignUpEvent {
  final SignUpData state;

  UpdateSignUpState(this.state);
}
