# Instagram Clone Flutter App

This is a Flutter app that implements an **Instagram Clone** using **BLoC architecture**. The app includes two main screens: **Login Screen** and **Sign Up Screen**, allowing users to access their account or create a new one. It supports **multi-language localization** for English, Hindi, and Gujarati.

## Features

- **Login Screen**: 
  - Users can log in using **username, phone number, or email** along with a **password**.
  - Language switcher to change between **English, Hindi, and Gujarati**.
  - **TODO**: Implement **Facebook Login** and **Forgot Password** features.

- **Sign Up Screen**: 
  - New users can create an account using fields like **mobile number or email**, **full name**, **username**, and **password**.
  - Password must meet the following criteria:
    - At least 6 characters.
    - Include letters, numbers, and special characters.
  - **TODO**: Implement **Login with Facebook** feature.

- **Hive Database**: 
  - User credentials are securely stored using **Hive** database for persistent data storage.

## Localization Support

- The app supports **three languages**: 
  - **English**
  - **Hindi**
  - **Gujarati**

Users can switch between these languages using the language switcher in the app.

## Requirements

To run this app on your local machine, you need to have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Hive](https://pub.dev/packages/hive)
