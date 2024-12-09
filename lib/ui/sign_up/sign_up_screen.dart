import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/extension/navigation_extensions.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:gap/gap.dart';

import '../../blocs/sign_up/sign_up_bloc.dart';
import '../../blocs/sign_up/sign_up_contract.dart';
import '../../core/app_extension.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/dimens.dart';
import '../../core/enum.dart';
import '../../core/images.dart';
import '../../core/routes.dart';
import '../../core/styles.dart';
import '../../localization/app_localization.dart';
import '../common/app_inkwell.dart';
import '../common/app_loader.dart';
import '../common/app_text_field.dart';
import '../common/app_toast.dart';
import '../common/buttons/elevated_button.dart';
import '../common/container_decoration.dart';
import '../common/full_screen_error.dart';
import '../common/highlight_text.dart';
import '../common/svg_icon.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState<SignUpBloc, SignUpScreen> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitSignUpEvent());
  }

  @override
  void onViewEvent(ViewAction event) async {
    switch (event.runtimeType) {
      case const (DisplayMessage):
        _buildHandleMessage(event as DisplayMessage);
        break;
      case const (NavigateScreen):
        _buildHandleActionEvent(event as NavigateScreen);
        break;
    }
  }

  void _buildHandleMessage(DisplayMessage displayMessage) {
    final message = displayMessage.message;
    final type = displayMessage.type;
    switch (type) {
      case DisplayMessageType.toast:
        context.showToast(AppToast(message: message!));
        break;
      default:
        break;
    }
  }

  Future<void> _buildHandleActionEvent(NavigateScreen screen) async {
    switch (screen.target) {
      case AppRoutes.loginScreen:
        navigatorKey.currentContext?.pushAndRemoveUntil(
          settings: RouteSettings(name: screen.target),
          builder: (context) => const LoginScreen(),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: ContainerLinearGradient()),
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          bottomNavigationBar: const _BottomView(),
          body: SafeArea(
              child: BlocProvider<SignUpBloc>(
                  create: (_) => bloc,
                  child: BlocBuilder<SignUpBloc, SignUpData>(
                      builder: (_, __) => _MainContent(bloc: bloc))))),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final SignUpBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.state.state) {
      case ScreenState.loading:
        return const AppLoader();
      case ScreenState.content:
        return _SignUpContent(bloc: bloc);
      default:
        return FullScreenError(
            message: bloc.state.errorMessage!,
            onRetryTap: () {
              /// NOTE : retry event : bloc.add(<event_name>)
            });
    }
  }
}

class _SignUpContent extends StatelessWidget {
  final SignUpBloc bloc;

  const _SignUpContent({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spaceLarge),
      decoration: const BoxDecoration(gradient: ContainerLinearGradient()),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _LogoTextView(),
            const Gap(Dimens.spaceSmall),
            _FacBookButton(bloc: bloc),
            const _ORView(),
            _TextFieldsView(bloc: bloc),
            const Gap(Dimens.spaceSmall),
            const _PolicyText(),
            const Gap(Dimens.spaceSmall),
            _SignUpButton(bloc: bloc),
          ],
        ),
      ),
    );
  }
}

class _LogoTextView extends StatelessWidget {
  const _LogoTextView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSvgIcon(Images.instagramTextIcon),
        const Gap(Dimens.spaceSmall),
        Text(AppLocalization.currentLocalization().signTopText,
            textAlign: TextAlign.center,
            style: AppFontTextStyles.textStyleMedium()),
        const Gap(Dimens.spaceSmall),
      ],
    );
  }
}

class _TextFieldsView extends StatelessWidget {
  final SignUpBloc bloc;

  const _TextFieldsView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: SignUpTextFieldEnum.values
            .map((element) =>
                _TextFieldItemView(signUpTextFieldEnum: element, bloc: bloc))
            .toList());
  }
}

class _TextFieldItemView extends StatelessWidget {
  final SignUpTextFieldEnum signUpTextFieldEnum;
  final SignUpBloc bloc;

  const _TextFieldItemView(
      {required this.signUpTextFieldEnum, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final bool isLast = signUpTextFieldEnum == SignUpTextFieldEnum.password;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space4xSmall),
      child: AppTextField(
        labelText: signUpTextFieldEnum.title,
        onSubmitted: (_) => isLast ? bloc.add(SignUpButtonTapEvent()) : null,
        textInputAction: !isLast ? TextInputAction.next : TextInputAction.done,
        suffixIconType: isLast ? TextFieldSuffixIconType.showObscureText : null,
        obscureText: isLast,
        errorText: bloc.getErrorText(signUpTextFieldEnum: signUpTextFieldEnum),
        filled: true,
        backgroundColor: AppColors.white,
        textChanged: (text) => bloc.add(TextFieldChangedEvent(
            signUpTextFieldEnum: signUpTextFieldEnum, text: text)),
      ),
    );
  }
}

class _FacBookButton extends StatelessWidget {
  final SignUpBloc bloc;

  const _FacBookButton({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: AppLocalization.currentLocalization().loginWithFaceBook,
      prefixWidget: Container(
          color: AppColors.white,
          child: Image.asset(Images.facebook, height: Dimens.iconMedium)),
      onTap: () {},
      isLoading: bloc.state.isSignUpButtonLoading ?? false,
    );
  }
}

class _ORView extends StatelessWidget {
  const _ORView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.spaceXSmall, horizontal: Dimens.space4xSmall),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spaceMedium),
            child: Text(AppLocalization.currentLocalization().or),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final SignUpBloc bloc;

  const _SignUpButton({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: AppLocalization.currentLocalization().signUp,
      onTap: () => bloc.add(SignUpButtonTapEvent()),
      isLoading: bloc.state.isSignUpButtonLoading ?? false,
    );
  }
}

class _PolicyText extends StatelessWidget {
  const _PolicyText();

  @override
  Widget build(BuildContext context) {
    return HighlightText(
      textAlign: TextAlign.center,
      text: AppLocalization.currentLocalization().privacyPolicyText,
      style: AppFontTextStyles.textStyleSmall(),
      highlightStyle: AppFontTextStyles.textStyleSmall(),
      highlightText:
          AppLocalization.currentLocalization().privacyPolicyTextHighLight,
    );
  }
}

class _BottomView extends StatelessWidget {
  const _BottomView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spaceSmall),
      child: AppInkWell(
        onTap: () => navigatorKey.currentContext?.pop(),
        child: HighlightText(
          textAlign: TextAlign.center,
          text: AppLocalization.currentLocalization().haveAnAccount,
          style: AppFontTextStyles.textStyleMedium(),
          highlightStyle: AppFontTextStyles.textStyleMedium(),
          highlightText: AppLocalization.currentLocalization().login,
        ),
      ),
    );
  }
}
