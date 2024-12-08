import 'dart:async';
import 'dart:convert';

import '../../core/cache/preference_store.dart';
import '../../core/enum.dart';
import '../hive/hive_service.dart';
import '../hive/model/user_account_hive.dart';

class UserService {
  UserService(this._preferenceStore, this._hiveService);

  final PreferenceStore _preferenceStore;
  final HiveService _hiveService;

  FutureOr<void> init() async {}

  FutureOr<bool> signOut() async {
    _preferenceStore.reset();
    return true;
  }

  Future<bool> setUserLoginStatus({required bool isLoggedIn}) async =>
      await _preferenceStore.setValue(
          value: SharedPreferenceStore.IS_USER_LOGGED_IN, data: isLoggedIn);

  Future<bool> setCurrentUser(
          {required UserAccountHive userAccountHive}) async =>
      await _preferenceStore.setValue(
          value: SharedPreferenceStore.USER_DETAILS,
          data: jsonEncode(userAccountHive.toJson()));

  Future<bool> setLanguage({required String language}) async =>
      await _preferenceStore.setValue(
          value: SharedPreferenceStore.LANGUAGE_CODE, data: language);

  Future<bool> setThemeToLight({required bool setToLightTheme}) async =>
      await _preferenceStore.setValue(
          value: SharedPreferenceStore.IS_LIGHT_THEME, data: setToLightTheme);

  Future<void> addUserAccount(
          {required UserAccountHive userAccountHive}) async =>
      _hiveService.addUserAccount(userAccountHive: userAccountHive);

  Future<List<UserAccountHive>> getUserAccounts() async =>
      await _hiveService.getUserAccount();

  bool get isUserLoggedIn =>
      _preferenceStore.getValue(value: SharedPreferenceStore.IS_USER_LOGGED_IN);

  bool get isLightTheme =>
      _preferenceStore.getValue(value: SharedPreferenceStore.IS_LIGHT_THEME);

  String get serverToken =>
      _preferenceStore.getValue(value: SharedPreferenceStore.SERVER_TOKEN);

  UserAccountHive get currentUser => UserAccountHive.fromJson(jsonDecode(
      _preferenceStore.getValue(value: SharedPreferenceStore.USER_DETAILS)));

  String get language =>
      _preferenceStore.getValue(value: SharedPreferenceStore.LANGUAGE_CODE);
}
