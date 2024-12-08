import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/extension_imports.dart';

import '../../core/enum.dart';
import '../../core/routes.dart';
import '../../localization/app_localization.dart';
import '../../services/hive/model/user_account_hive.dart';
import '../../services/user/user_service.dart';
import 'sign_up_contract.dart';

class SignUpBloc extends BaseBloc<SignUpEvent, SignUpData> {
  SignUpBloc(this._userService) : super(initState) {
    on<InitSignUpEvent>(_initSignUpEvent);
    on<TextFieldChangedEvent>(_textFieldChangedEvent);
    on<SignUpButtonTapEvent>(_signUpButtonTapEvent);
    on<UpdateSignUpState>((event, emit) => emit(event.state));
  }

  final UserService _userService;

  static SignUpData get initState => (SignUpDataBuilder()
        ..state = ScreenState.loading
        ..mobileEmailController = TextEditingController()
        ..fullNameController = TextEditingController()
        ..passwordController = TextEditingController()
        ..usernameController = TextEditingController()
        ..errorMessage = '')
      .build();

  void _initSignUpEvent(_, __) => add(
      UpdateSignUpState(state.rebuild((u) => u..state = ScreenState.content)));

  void _textFieldChangedEvent(TextFieldChangedEvent event, _) {
    switch (event.signUpTextFieldEnum) {
      case SignUpTextFieldEnum.mobileEmail:
        add(UpdateSignUpState(state.rebuild((u) => u
          ..mobileEmailErrorMessage = ''
          ..mobileEmailController?.text = event.text)));
      case SignUpTextFieldEnum.fullName:
        add(UpdateSignUpState(state.rebuild((u) => u
          ..fullNameErrorMessage = ''
          ..fullNameController?.text = event.text)));
      case SignUpTextFieldEnum.username:
        add(UpdateSignUpState(state.rebuild((u) => u
          ..useNameErrorMessage = ''
          ..usernameController?.text = event.text)));
      case SignUpTextFieldEnum.password:
        add(UpdateSignUpState(state.rebuild((u) => u
          ..passwordErrorMessage = ''
          ..passwordController?.text = event.text)));
    }
  }

  TextEditingController? getTextController(
      {required SignUpTextFieldEnum signUpTextFieldEnum}) {
    switch (signUpTextFieldEnum) {
      case SignUpTextFieldEnum.mobileEmail:
        return state.mobileEmailController;
      case SignUpTextFieldEnum.fullName:
        return state.fullNameController;
      case SignUpTextFieldEnum.username:
        return state.usernameController;
      case SignUpTextFieldEnum.password:
        return state.passwordController;
    }
  }

  String? getErrorText({required SignUpTextFieldEnum signUpTextFieldEnum}) {
    switch (signUpTextFieldEnum) {
      case SignUpTextFieldEnum.mobileEmail:
        return state.mobileEmailErrorMessage;
      case SignUpTextFieldEnum.fullName:
        return state.fullNameErrorMessage;
      case SignUpTextFieldEnum.username:
        return state.useNameErrorMessage;
      case SignUpTextFieldEnum.password:
        return state.passwordErrorMessage;
    }
  }

  void _signUpButtonTapEvent(_, __) async {
    if (_isValidData()) {
      _updateLoginButtonState(true);
      if (await _haveAccount()) {
        _dispatchMessage(
            message: AppLocalization.currentLocalization().alreadyHaveAccount);
      } else {
        await _userService.addUserAccount(
            userAccountHive: UserAccountHive(
                mobileOrEmail: state.mobileEmailController.text.trim(),
                fullName: state.fullNameController.text.trim(),
                username: state.usernameController.text.trim(),
                password: state.passwordController.text.trim(),
                userId: state.mobileEmailController.text.trim() +
                    state.usernameController.text.trim() +
                    state.passwordController.text.trim()));
        dispatchViewEvent(NavigateScreen(AppRoutes.loginScreen));
      }
      add(UpdateSignUpState(
          state.rebuild((u) => u..isSignUpButtonLoading = false)));
    }
  }

  Future<bool> _haveAccount() async {
    final list = await _userService.getUserAccounts();
    for (var element in list) {
      if ((state.usernameController.text == element.username &&
              state.mobileEmailController.text == element.mobileOrEmail) &&
          state.passwordController.text == element.password) {
        _userService.setCurrentUser(userAccountHive: element);
        return true;
      }
    }
    return false;
  }

  bool _isValidData() {
    String mobileEmailError = state.mobileEmailController.text.isBlank
        ? AppLocalization.currentLocalization().mobileEmailError
        : '';

    String fullNameError = state.fullNameController.text.isBlank
        ? AppLocalization.currentLocalization().fullNameError
        : '';

    String loginUserNameError = state.usernameController.text.isBlank
        ? AppLocalization.currentLocalization().signUpUserNameError
        : '';

    String passwordError = _validatePassword(state.passwordController.text);

    add(UpdateSignUpState(state.rebuild((u) => u
      ..useNameErrorMessage = loginUserNameError
      ..fullNameErrorMessage = fullNameError
      ..mobileEmailErrorMessage = mobileEmailError
      ..passwordErrorMessage = passwordError)));

    if (loginUserNameError.isNotBlank ||
        passwordError.isNotBlank ||
        fullNameError.isNotBlank ||
        mobileEmailError.isNotBlank) {
      return false;
    }

    return true;
  }

  String _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must include letters, numbers, and special characters';
    }
    return '';
  }

  void _dispatchMessage({required String message}) => dispatchViewEvent(
      DisplayMessage(type: DisplayMessageType.toast, message: message));

  void _updateLoginButtonState(bool status) => add((UpdateSignUpState(
      state.rebuild((u) => u.isSignUpButtonLoading = status))));
}
