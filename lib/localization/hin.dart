import 'app_localization.dart';

class HindiLocalization extends AppLocalization {
  HindiLocalization() : super(code: 'hin', name: 'हिन्दी');

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
  String get english => 'हिन्दी';

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
}
