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
  String get retry => 'पुनः प्रयास करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get english => 'हिन्दी';

  @override
  String get password => 'पासवर्ड';

  @override
  String get usernameLogin => 'उपयोगकर्ता नाम, ईमेल या मोबाइल नंबर';

  @override
  String get loginUserNameError =>
      'कृपया वैध उपयोगकर्ता नाम, ईमेल या मोबाइल नंबर दर्ज करें';

  @override
  String get passwordError => 'पासवर्ड खाली नहीं होना चाहिए!';

  @override
  String get login => 'लॉग इन';

  @override
  String get forgetPassword => 'पासवर्ड भूल गए?';

  @override
  String get invalidCredentials => 'अमान्य क्रेडेंशियल्स!';

  @override
  String get createNewAccount => 'नया खाता बनाएँ';

  @override
  String get selectYourLanguage => 'अपनी भाषा चुनें';

  @override
  String get fullNameError => 'कृपया वैध पूरा नाम दर्ज करें';

  @override
  String get mobileEmailError => 'कृपया वैध मोबाइल नंबर या ईमेल दर्ज करें';

  @override
  String get signUpUserNameError => 'कृपया वैध उपयोगकर्ता नाम दर्ज करें';

  @override
  String get loginWithFaceBook => 'फेसबुक से लॉगिन करें';

  @override
  String get or => 'या';

  @override
  String get signUp => 'साइन अप';

  @override
  String get mobileEmail => 'मोबाइल नंबर या ईमेल';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get usernameSignUp => 'उपयोगकर्ता नाम';

  @override
  String get haveAnAccount => 'क्या आपके पास खाता है? लॉग इन करें';

  @override
  String get signTopText =>
      'साइन अप करें और अपने दोस्तों से फ़ोटो और वीडियो देखें';

  @override
  String get privacyPolicyText =>
      'साइन अप करके, आप हमारी शर्तों, गोपनीयता नीति और कुकी नीति से सहमति देते हैं';

  @override
  String get privacyPolicyTextHighLight => 'शर्तों, गोपनीयता नीति और कुकी नीति';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है, कृपया साइन इन करें!';
}
