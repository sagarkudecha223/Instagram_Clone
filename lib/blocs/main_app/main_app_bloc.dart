import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/api_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/localization_imports.dart';

import '../../core/cache/preference_store.dart';
import '../../core/constants.dart';
import '../../core/enum.dart';
import '../../core/event_buses.dart';
import '../../core/routes.dart';
import '../../localization/app_localization.dart';
import '../../services/theme_service/theme_service.dart';
import '../../services/user/user_service.dart';
import 'main_app_contract.dart';

class MainAppBloc extends BaseBloc<MainAppEvent, MainAppData> {
  MainAppBloc(
      this._themeService,
      this._eventBus,
      this._userService,
      this._preferenceStore,
      this._localizationService,
      this._baseArchController)
      : super(initState) {
    on<InitEvent>(_initEvent);
    on<SetRestApiConfigurationEvent>(_setRestApiConfigurationEvent);
    on<SetLocalizationEvent>(_setLocalizationEvent);
    on<SetProtectedRoutesEvent>(_setProtectedRoutesEvent);
    on<DisposeEvent>(_disposeEvent);
    on<InActiveEvent>(_inActiveEvent);
    on<AppResumedEvent>(_appResumedEvent);
    on<ChangeThemeEvent>(_changeTheme);
    on<UpdateMainAppState>((event, emit) => emit(event.state));
    _observeEventBus();
  }

  final ThemeService _themeService;
  final UserService _userService;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;
  final LocalizationService _localizationService;
  final BaseArchController _baseArchController;

  static MainAppData get initState => (MainAppDataBuilder()
        ..state = ScreenState.loading
        ..isGuestUser = false
        ..isLoggedIn = false
        ..appThemeData = ThemeData.light())
      .build();

  void _initEvent(_, __) {
    add(SetRestApiConfigurationEvent());
    add(SetLocalizationEvent());
    add(SetProtectedRoutesEvent());
    add(UpdateMainAppState(state.rebuild((u) => u
      ..isLoggedIn = _userService.isUserLoggedIn
      ..state = ScreenState.content)));
  }

  void _setRestApiConfigurationEvent(_, __) {
    _baseArchController.setRestApiConfiguration(
        restApiConfiguration: RestApiConfiguration(headers: {
      'token': _userService.serverToken,
    }, customResponseEntityList: [
      CustomResponseEntity(
          statusCode: 422,
          errorMessage: (dynamic response) {
            return ErrorResult(
                errorMessage: response.response?.data['message'],
                type: ErrorResultType.other);
          }),
      CustomResponseEntity(
          statusCode: 503,
          errorMessage: (dynamic response) {
            return ErrorResult(
                errorMessage:
                    AppLocalization.currentLocalization().somethingWentWrong,
                type: ErrorResultType.serverNotAvailable);
          }),
    ]));
  }

  void _setLocalizationEvent(_, __) {
    _baseArchController.setLocalization(
        localizationList: AppConstants.localizationList);
    final list = AppConstants.localizationList;
    final localization = list.firstWhere(
      (loc) =>
          loc.code ==
          _preferenceStore.getValue(value: SharedPreferenceStore.LANGUAGE_CODE),
      orElse: () => list[0],
    );
    _localizationService.changeLocalization(localization);
  }

  void _setProtectedRoutesEvent(_, __) =>
      _baseArchController.setProtectedRoutes(
          isAuthenticated: _userService.isUserLoggedIn,
          protectedRoutesList: AppRoutes().protectedRoutsList());

  void _inActiveEvent(_, __) => printLog(message: 'App is Inactive');

  void _appResumedEvent(_, __) => _eventBus.sendEvent(AppResumedBusEvent());

  void _disposeEvent(_, __) => exit(0);

  void _changeTheme(_, emit) {
    emit(state.rebuild((u) {
      _themeService.changeTheme();
      u.appThemeData = _themeService.getThemeData();
    }));
    dispatchViewEvent(ChangeTheme());
  }

  void _observeEventBus() =>
      _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {
      case const (SignOutBusEvent):
        final status = await _userService.signOut();
        if (status) {
          dispatchViewEvent(NavigateScreen(AppRoutes.loginScreen));
        }
        break;
      case const (ChangeThemeBusEvent):
        dispatchViewEvent(ChangeTheme());
        break;
      case const (UpdateHeaderBusEvent):
        add(SetRestApiConfigurationEvent());
        break;
    }
  }
}
