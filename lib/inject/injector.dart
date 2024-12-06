// ignore_for_file: constant_identifier_names
import 'package:flutter_base_architecture_plugin/imports/api_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/injector_imports.dart';
import 'package:flutter_base_architecture_plugin/services/localization/localization_service.dart';

import '../apis/api_names.dart';
import '../blocs/full_screen_error/full_screen_error_bloc.dart';
import '../blocs/main_app/main_app_bloc.dart';
import '../core/cache/preference_store.dart';
import '../services/theme_service/app_theme.dart';
import '../services/theme_service/theme_service.dart';
import '../services/user/permission_handler_service.dart';
import '../services/user/user_service.dart';

part 'injector.g.dart';

abstract class Injector extends BaseInjector {
  static late KiwiContainer container;

  static Future<bool> setup() async {
    container = BaseInjector.baseContainer;

    _$Injector()._configure();

    await container.resolve<PreferenceStore>().init();
    await container.resolve<UserService>().init();

    return true;
  }

  void _configure() {
    // Configure modules here
    _registerConstants();
    _registerMiscModules();
    _registerApis();
    _registerServices();
    _registerCache();
    _registerBlocProviders();
  }

  void _registerConstants() {
    container.registerSingleton((c) => API_URL_TESTING, name: API_KEY);
  }

  @Register.singleton(AppTheme)
  void _registerMiscModules();

  /// Register Data Stores
  @Register.singleton(PreferenceStore)
  void _registerCache();

  /// Register Apis
  void _registerApis();

  /// Register Services
  @Register.singleton(ThemeService)
  @Register.singleton(UserService)
  @Register.singleton(PermissionHandlerService)
  void _registerServices();

  /// Register Bloc dependencies
  @Register.factory(MainAppBloc)
  @Register.factory(FullScreenErrorBloc)
  void _registerBlocProviders();
}
