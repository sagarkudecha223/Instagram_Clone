import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/core/base_state.dart';
import 'package:flutter_base_architecture_plugin/core/view_actions.dart';
import 'package:gap/gap.dart';

import '../../blocs/full_screen_error/full_screen_error_bloc.dart';
import '../../blocs/full_screen_error/full_screen_error_contractor.dart';
import '../../core/colors.dart';
import '../../core/dimens.dart';
import '../../core/styles.dart';
import '../../localization/app_localization.dart';
import 'buttons/elevated_button.dart';

class FullScreenError extends StatefulWidget {
  final String title;
  final String message;
  final String? buttonTitle;
  final Function onRetryTap;

  const FullScreenError(
      {required this.onRetryTap,
      this.message = '',
      this.title = '',
      this.buttonTitle,
      super.key});

  @override
  State<FullScreenError> createState() => _FullScreenErrorState();
}

class _FullScreenErrorState
    extends BaseState<FullScreenErrorBloc, FullScreenError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              widget.title,
              style: AppFontTextStyles.textStyleBold(),
              textAlign: TextAlign.center,
            ),
            const Gap(Dimens.spaceSmall),
            Text(
              widget.message,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: AppFontTextStyles.textStyleMedium().copyWith(
                  overflow: TextOverflow.visible,
                  fontSize: Dimens.fontSizeSixteen),
            ),
            const Gap(Dimens.spaceLarge),
            AppElevatedButton(
              title: widget.buttonTitle ??
                  AppLocalization.currentLocalization().retry,
              onTap: widget.onRetryTap as void Function()?,
              titleTextStyle: AppFontTextStyles.textStyleBold().copyWith(
                  fontSize: Dimens.fontSizeFourteen, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewEvent(ViewAction event) async {
    switch (event.runtimeType) {
      case const (NavigateScreen):
        final screen = event as NavigateScreen;
        switch (screen.target) {
          case FullScreenErrorTarget.NETWORK_RESTORED:
            widget.onRetryTap();
            break;
        }
        break;
    }
  }
}
