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
  String get retry => 'ફરીથી પ્રયાસ કરો';

  @override
  String get ok => 'બરાબર';

  @override
  String get english => 'ગુજરાતી';

  @override
  String get password => 'પાસવર્ડ';

  @override
  String get usernameLogin => 'યુઝરનેમ, ઈમેઈલ અથવા મોબાઈલ નંબર';

  @override
  String get loginUserNameError =>
      'કૃપા કરીને માન્ય યુઝરનેમ, ઈમેઈલ અથવા મોબાઈલ નંબર દાખલ કરો';

  @override
  String get passwordError => 'પાસવર્ડ ખાલી ન હોઈને જોઈએ!';

  @override
  String get login => 'લોગિન કરો';

  @override
  String get forgetPassword => 'પાસવર્ડ ભૂલી ગયા છો?';

  @override
  String get invalidCredentials => 'અમાન્ય ક્રેડેંશિયલ્સ!';

  @override
  String get createNewAccount => 'નવી ખાતું બનાવો';

  @override
  String get selectYourLanguage => 'તમારી ભાષા પસંદ કરો';

  @override
  String get fullNameError => 'કૃપા કરીને માન્ય સંપૂર્ણ નામ દાખલ કરો';

  @override
  String get mobileEmailError =>
      'કૃપા કરીને માન્ય મોબાઈલ નંબર અથવા ઈમેઈલ દાખલ કરો';

  @override
  String get signUpUserNameError => 'કૃપા કરીને માન્ય યુઝરનેમ દાખલ કરો';

  @override
  String get loginWithFaceBook => 'ફેસબુક સાથે લોગિન કરો';

  @override
  String get or => 'અથવા';

  @override
  String get signUp => 'સાઇન અપ કરો';

  @override
  String get mobileEmail => 'મોબાઈલ નંબર અથવા ઈમેઈલ';

  @override
  String get fullName => 'પૂર્ણ નામ';

  @override
  String get usernameSignUp => 'યુઝરનેમ';

  @override
  String get haveAnAccount => 'શું તમારું પહેલાથી એક ખાતું છે? લોગિન કરો';

  @override
  String get signTopText =>
      'સાઇન અપ કરો અને તમારા મિત્રોથી ફોટા અને વિડિઓઝ જુઓ';

  @override
  String get privacyPolicyText =>
      'સાઇન અપ કરીને, તમે અમારી શરતો, ગોપનીયતા નીતિ અને કૂકી નીતિ સાથે સંમત છો';

  @override
  String get privacyPolicyTextHighLight => 'શરતો, ગોપનીયતા નીતિ અને કૂકી નીતિ';

  @override
  String get alreadyHaveAccount => 'પહેલેથી ખાતું છે, કૃપા કરીને સાઇન ઇન કરો!';
}
