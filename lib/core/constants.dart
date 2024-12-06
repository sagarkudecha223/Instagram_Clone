// ignore_for_file: constant_identifier_names, type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/utils_imports.dart';

import '../localization/en.dart';

var navigatorKey = GlobalKey<NavigatorState>();
NavigatorMiddleware<PageRoute> middleware = NavigatorMiddleware<PageRoute>();
var currentRouteName = '';
class AppConstants{
  static final localizationList = [EnglishLocalization()];

}