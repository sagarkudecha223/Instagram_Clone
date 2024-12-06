// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names

const String API_URL_DEV = 'https://api.nasa.gov/';
const String API_URL_TESTING = 'https://api.nasa.gov/';

///Base url used for APi call
const String API_URL = API_URL_DEV;
const String API_KEY = 'api_key';

abstract class Apis {
  static const marsPhotos =
      API_URL + 'mars-photos/api/v1/rovers/curiosity/photos';
}
