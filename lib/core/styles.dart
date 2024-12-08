import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

abstract class AppFontTextStyles {
  static const fontFamily = 'proxima_nova';

  static TextStyle textStyleSmall() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeTwelve,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.07);

  static TextStyle textStyleMedium() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: Dimens.fontSizeSixteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleLarge() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeSixteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.8);

  static TextStyle textStyleBold() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.07);

  static TextStyle buttonTextStyle() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeSixteen,
      color: AppColors.white,
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.8);

  static TextStyle appbarTextStyle() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.appBarTextColor,
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.07);
}
