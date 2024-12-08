import 'package:flutter/cupertino.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/extension_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/localization_imports.dart';

import '../../core/enum.dart';
import '../../core/routes.dart';
import '../../localization/app_localization.dart';
import '../../services/user/user_service.dart';
import 'login_contract.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginData> {
  LoginBloc(this._userService, this._localizationService) : super(initState) {
    on<InitLoginEvent>(_initLoginEvent);
    on<TextFieldChangedEvent>(_textFieldChangedEvent);
    on<SelectLanguageTapEvent>(_selectLanguageTapEvent);
    on<LanguageTapEvent>(_languageTapEvent);
    on<CreteAccountTapEvent>(_creteAccountTapEvent);
    on<LoginButtonTapEvent>(_loginButtonTapEvent);
    on<UpdateLoginState>((event, emit) => emit(event.state));
  }

  final UserService _userService;
  final LocalizationService _localizationService;

  static LoginData get initState => (LoginDataBuilder()
        ..state = ScreenState.loading
        ..passwordController = TextEditingController()
        ..usernameController = TextEditingController()
        ..userAccountsList = []
        ..errorMessage = '')
      .build();

  void _initLoginEvent(_, __) async {
    final list = await _userService.getUserAccounts();
    final lang = _userService.language;
    add(UpdateLoginState(state.rebuild((u) => u
      ..state = ScreenState.content
      ..userAccountsList = list
      ..selectedLanguageCode = lang
      ..selectedLanguageCode = _userService.language)));
  }

  void _textFieldChangedEvent(TextFieldChangedEvent event, _) {
    switch (event.loginTextFieldEnum) {
      case LoginTextFieldEnum.username:
        add(UpdateLoginState(state.rebuild((u) => u
          ..useNameErrorMessage = ''
          ..usernameController?.text = event.text)));
      case LoginTextFieldEnum.password:
        add(UpdateLoginState(state.rebuild((u) => u
          ..passwordErrorMessage = ''
          ..passwordController?.text = event.text)));
    }
  }

  TextEditingController? getTextController(
      {required LoginTextFieldEnum loginTextFieldEnum}) {
    switch (loginTextFieldEnum) {
      case LoginTextFieldEnum.username:
        return state.usernameController;
      case LoginTextFieldEnum.password:
        return state.passwordController;
    }
  }

  String? getErrorText({required LoginTextFieldEnum loginTextFieldEnum}) {
    switch (loginTextFieldEnum) {
      case LoginTextFieldEnum.username:
        return state.useNameErrorMessage;
      case LoginTextFieldEnum.password:
        return state.passwordErrorMessage;
    }
  }

  void _updateLoginButtonState(bool status) => add((UpdateLoginState(
      state.rebuild((u) => u.isLoginButtonLoading = status))));

  void _loginButtonTapEvent(_, __) {
    if (_isValidData()) {
      _updateLoginButtonState(true);
      if (_haveAccount()) {
        dispatchViewEvent(NavigateScreen(AppRoutes.editProfileScreen));
      } else {
        _dispatchMessage(
            AppLocalization.currentLocalization().invalidCredentials);
      }
      add(UpdateLoginState(
          state.rebuild((u) => u..isLoginButtonLoading = false)));
    }
  }

  bool _haveAccount() {
    for (var element in state.userAccountsList) {
      if ((state.usernameController.text == element.username ||
              state.usernameController.text == element.mobileOrEmail) &&
          state.passwordController.text == element.password) {
        _userService.setCurrentUser(userAccountHive: element);
        return true;
      }
    }
    return false;
  }

  bool _isValidData() {
    String loginUserNameError = state.usernameController.text.isBlank
        ? AppLocalization.currentLocalization().loginUserNameError
        : '';

    String passwordError = state.passwordController.text.isBlank
        ? AppLocalization.currentLocalization().passwordError
        : '';

    add(UpdateLoginState(state.rebuild((u) => u
      ..useNameErrorMessage = loginUserNameError
      ..passwordErrorMessage = passwordError)));

    if (loginUserNameError.isNotBlank || passwordError.isNotBlank) {
      return false;
    }

    return true;
  }

  void _creteAccountTapEvent(_, __) =>
      dispatchViewEvent(NavigateScreen(AppRoutes.signUpScreen));

  void _selectLanguageTapEvent(_, __) =>
      dispatchViewEvent(NavigateScreen(AppRoutes.languageBottomScreen));

  void _languageTapEvent(LanguageTapEvent event, __) async {
    await _userService.setLanguage(language: event.languageCode);
    await _localizationService.changeLocalization(event.localization);
    add((UpdateLoginState(state.rebuild((u) => u
      ..selectedLanguageCode = event.languageCode
      ..useNameErrorMessage = ''
      ..passwordErrorMessage = ''))));
    dispatchViewEvent(CloseScreen());
  }

  void _dispatchMessage(String message) => dispatchViewEvent(
      DisplayMessage(message: message, type: DisplayMessageType.toast));
}
