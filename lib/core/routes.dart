class AppRoutes {
  static const String homeScreen = '/homeScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String languageBottomScreen = '/languageBottomScreen';

  /// for the guest user
  List<String> protectedRoutsList() {
    return [];
  }
}
