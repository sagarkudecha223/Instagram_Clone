import 'app_localization.dart';

class EnglishLocalization extends AppLocalization {
  EnglishLocalization() : super(code: 'en', name: 'English');

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
  String get english => 'English';

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
  String get fullNameError => 'Kindly enter valid Full Name';

  @override
  String get mobileEmailError => 'Kindly enter valid Mobile Number or Email';

  @override
  String get signUpUserNameError => 'Kindly enter valid Username';

  @override
  String get loginWithFaceBook => 'Log in with FaceBook';

  @override
  String get or => 'OR';

  @override
  String get signUp => 'Sign up';

  @override
  String get mobileEmail => 'Mobile Number or Email';

  @override
  String get fullName => 'Full Name';

  @override
  String get usernameSignUp => 'Username';

  @override
  String get haveAnAccount => 'Have an account? Log in';

  @override
  String get signTopText =>
      'Sign up to see photos and videos\n from your friends';

  @override
  String get privacyPolicyText =>
      'By singing up, you agree to our Terms, Privacy Policy and Cookies Policy';

  @override
  String get privacyPolicyTextHighLight =>
      'Terms, Privacy Policy and Cookies Policy';

  @override
  String get alreadyHaveAccount => 'Already have an account please Sign in!';
}
