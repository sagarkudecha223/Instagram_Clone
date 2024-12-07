import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import '../../core/styles.dart';
import 'app_image_filters.dart';

class AppToast extends StatelessWidget {
  final String message;

  const AppToast({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimens.spaceLarge),
        child: BackdropFilter(
            filter: AppImageFilters.blurLow,
            child: Container(
                decoration: ShapeDecoration(
                    shape: StadiumBorder(), color: AppColors.buttonColor),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spaceLarge,
                    vertical: Dimens.spaceXMedium),
                child: Text(message,
                    style: AppFontTextStyles.textStyleBold()
                        .copyWith(color: AppColors.white),
                    overflow: TextOverflow.visible))));
  }
}
