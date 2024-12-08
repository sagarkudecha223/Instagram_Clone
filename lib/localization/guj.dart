import 'app_localization.dart';

class GujaratiLocalization extends AppLocalization {
  GujaratiLocalization() : super(code: 'guj', name: 'ગુજરાતી');

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get cancelApiRequestError => 'Request to API server was cancelled';

  @override
  String get connectionTimeoutApiRequestError =>
      'Connection timeout with API server';

  @override
  String get invalidStatusApiRequestError => 'Received invalid status code %s';

  @override
  String get receiveTimeoutApiRequestError =>
      'Receive timeout in connection with API server';

  @override
  String get somethingWentWrong => 'Something went wrong.';

  @override
  String get connectionError => 'Connection error';

  @override
  String get retry => 'Re-Try';

  @override
  String get ok => 'Ok';

  @override
  String get english => 'ગુજરાતી';

  @override
  String get password => 'Password';

  @override
  String get usernameLogin => 'Username, email or mobile number';

  @override
  String get loginUserNameError =>
      'Kindly enter valid Username, email or mobile number';

  @override
  String get passwordError => 'Password should not be blank!';

  @override
  String get login => 'Log in';

  @override
  String get forgetPassword => 'Forgot Password?';

  @override
  String get invalidCredentials => 'Invalid credentials!';

  @override
  String get createNewAccount => 'Create new account';

  @override
  String get selectYourLanguage => 'Select your language';

  @override
  // TODO: implement fullName
  String get fullName => throw UnimplementedError();

  @override
  // TODO: implement mobileEmail
  String get mobileEmail => throw UnimplementedError();

  @override
  // TODO: implement usernameSignUp
  String get usernameSignUp => throw UnimplementedError();

  @override
  // TODO: implement fullNameError
  String get fullNameError => throw UnimplementedError();

  @override
  // TODO: implement mobileEmailError
  String get mobileEmailError => throw UnimplementedError();

  @override
  // TODO: implement signUp
  String get signUp => throw UnimplementedError();

  @override
  // TODO: implement loginWithFaceBook
  String get loginWithFaceBook => throw UnimplementedError();

  @override
  // TODO: implement alreadyHaveAccount
  String get alreadyHaveAccount => throw UnimplementedError();

  @override
  // TODO: implement haveAnAccount
  String get haveAnAccount => throw UnimplementedError();

  @override
  // TODO: implement or
  String get or => throw UnimplementedError();

  @override
  // TODO: implement privacyPolicyText
  String get privacyPolicyText => throw UnimplementedError();

  @override
  // TODO: implement privacyPolicyTextHighLight
  String get privacyPolicyTextHighLight => throw UnimplementedError();

  @override
  // TODO: implement signTopText
  String get signTopText => throw UnimplementedError();

  @override
  // TODO: implement signUpUserNameError
  String get signUpUserNameError => throw UnimplementedError();
}
