import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants.dart';
import 'model/user_account_hive.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() => Hive.registerAdapter(UserAccountHiveAdapter());

  Future<void> _openBoxes() async =>
      await Hive.openBox<UserAccountHive>(AppConstants.kUserAccountBox);

  Box get _userAccountHiveBox =>
      Hive.box<UserAccountHive>(AppConstants.kUserAccountBox);

  Future<void> addUserAccount({required UserAccountHive userAccountHive}) async => _userAccountHiveBox.add(userAccountHive);

  Future<List<UserAccountHive>> getUserAccount() async {
    try {
      final List<UserAccountHive> userAccountList = _userAccountHiveBox.values
          .map((element) => element as UserAccountHive)
          .toList();
      return userAccountList;
    } catch (e) {
      printLog(message: 'Error: $e');
      return [];
    }
  }

  }
