import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/extension_imports.dart';
import 'package:gap/gap.dart';

import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_contract.dart';
import '../../core/app_extension.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/dimens.dart';
import '../../core/enum.dart';
import '../../core/images.dart';
import '../../core/routes.dart';
import '../../core/styles.dart';
import '../../localization/app_localization.dart';
import '../common/app_checkbox.dart';
import '../common/app_inkwell.dart';
import '../common/app_loader.dart';
import '../common/app_text_field.dart';
import '../common/app_toast.dart';
import '../common/buttons/elevated_button.dart';
import '../common/buttons/icon_button.dart';
import '../common/buttons/text_button.dart';
import '../common/container_decoration.dart';
import '../common/full_screen_error.dart';
import '../common/svg_icon.dart';
import '../profile/profile_screen.dart';
import '../sign_up/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginBloc, LoginScreen> {
  @override
  void initState() {
    super.initState();
    bloc.add((InitLoginEvent()));
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
      case const (CloseScreen):
        navigatorKey.currentContext?.pop();
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
      case AppRoutes.languageBottomScreen:
        navigatorKey.currentContext?.showBottomSheet(
            child: _LanguageBottomSheet(bloc: bloc),
            backgroundColor: AppColors.white,
            borderRadius: Dimens.radius2xMedium);
      case AppRoutes.signUpScreen:
        navigatorKey.currentContext?.push(
            settings: RouteSettings(name: screen.target),
            builder: (context) => const SignUpScreen());
        break;
      case AppRoutes.editProfileScreen:
        navigatorKey.currentContext?.pushAndRemoveUntil(
          settings: RouteSettings(
            name: screen.target,
          ),
          builder: (context) => const EditProfile(),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: ContainerLinearGradient()),
      padding: const EdgeInsets.all(Dimens.spaceMedium),
      child: BlocProvider<LoginBloc>(
          create: (_) => bloc,
          child: BlocBuilder<LoginBloc, LoginData>(
              builder: (_, __) => Scaffold(
                    backgroundColor: AppColors.transparent,
                    resizeToAvoidBottomInset: false,
                    bottomNavigationBar: _BottomView(bloc: bloc),
                    body: SafeArea(child: _MainContent(bloc: bloc)),
                  ))),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.state.state) {
      case ScreenState.loading:
        return const AppLoader();
      case ScreenState.content:
        return _LoginContent(bloc: bloc);
      default:
        return FullScreenError(
            message: bloc.state.errorMessage!,
            onRetryTap: () => bloc.add(InitLoginEvent()));
    }
  }
}

class _LoginContent extends StatelessWidget {
  final LoginBloc bloc;

  const _LoginContent({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(Dimens.spaceMedium),
        _LanguageView(bloc: bloc),
        const Gap(Dimens.space5xLarge),
        const _LogoView(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LoginTextFieldView(bloc: bloc),
              const Gap(Dimens.space4xSmall),
              _LoginButton(
                isLoading: bloc.state.isLoginButtonLoading ?? false,
                onTap: () => bloc.add(LoginButtonTapEvent()),
              ),
              const Gap(Dimens.spaceMedium),
              _ForgottenPasswordView(),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageView extends StatelessWidget {
  final LoginBloc bloc;

  const _LanguageView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () => bloc.add(SelectLanguageTapEvent()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalization.currentLocalization().english,
              style: AppFontTextStyles.textStyleMedium()),
          const AppSvgIcon(Images.downArrow)
        ],
      ),
    );
  }
}

class _LogoView extends StatelessWidget {
  const _LogoView();

  @override
  Widget build(BuildContext context) {
    return Image.asset(Images.instagramLogo,
        height: MediaQuery.of(context).size.height * 0.13);
  }
}

class _LoginTextFieldView extends StatelessWidget {
  final LoginBloc bloc;

  const _LoginTextFieldView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: LoginTextFieldEnum.values
          .map((element) => _CommonTextField(
                loginTextFieldEnum: element,
                bloc: bloc,
                isPasswordText: element == LoginTextFieldEnum.password,
              ))
          .toList(),
    );
  }
}

class _CommonTextField extends StatelessWidget {
  final LoginTextFieldEnum loginTextFieldEnum;
  final bool isPasswordText;
  final LoginBloc bloc;

  const _CommonTextField(
      {required this.loginTextFieldEnum,
      required this.bloc,
      required this.isPasswordText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space2xSmall),
      child: AppTextField(
        labelText: loginTextFieldEnum.title,
        onSubmitted: (_) =>
            isPasswordText ? bloc.add(LoginButtonTapEvent()) : null,
        textInputAction:
            !isPasswordText ? TextInputAction.next : TextInputAction.done,
        onTapOutside: navigatorKey.currentContext?.hideKeyboard,
        suffixIconType:
            isPasswordText ? TextFieldSuffixIconType.showObscureText : null,
        obscureText: isPasswordText,
        errorText: bloc.getErrorText(loginTextFieldEnum: loginTextFieldEnum),
        filled: true,
        backgroundColor: AppColors.white,
        textChanged: (text) => bloc.add(TextFieldChangedEvent(
            loginTextFieldEnum: loginTextFieldEnum, text: text)),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final Function() onTap;

  const _LoginButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: AppLocalization.currentLocalization().login,
      onTap: onTap,
      isLoading: isLoading,
    );
  }
}

class _ForgottenPasswordView extends StatelessWidget {
  const _ForgottenPasswordView();

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalization.currentLocalization().forgetPassword,
        style: AppFontTextStyles.textStyleLarge());
  }
}

class _BottomView extends StatelessWidget {
  final LoginBloc bloc;

  const _BottomView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CreateAccountButton(onTap: () => bloc.add(CreteAccountTapEvent())),
        const Gap(Dimens.spaceSmall),
        const _MetaView(),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  final Function() onTap;

  const _CreateAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      title: AppLocalization.currentLocalization().createNewAccount,
      hasBorder: true,
      textColor: AppColors.buttonColor,
      onTap: onTap,
    );
  }
}

class _MetaView extends StatelessWidget {
  const _MetaView();

  @override
  Widget build(BuildContext context) {
    return AppSvgIcon(Images.metaLogo,
        height: MediaQuery.of(context).size.height * 0.018);
  }
}

class _LanguageBottomSheet extends StatelessWidget {
  final LoginBloc bloc;

  const _LanguageBottomSheet({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spaceSmall),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius2xMedium),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.screenBackgroundGradientColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIconButton(
            iconWidget:
                const AppSvgIcon(Images.cancel, height: Dimens.iconLarge),
            backgroundColor: AppColors.transparent,
            onTap: () => navigatorKey.currentContext?.pop(),
          ),
          _SelectLanguageView(bloc: bloc)
        ],
      ),
    );
  }
}

class _SelectLanguageView extends StatelessWidget {
  final LoginBloc bloc;

  const _SelectLanguageView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spaceXMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.currentLocalization().selectYourLanguage,
            style: AppFontTextStyles.textStyleLarge()
                .copyWith(fontSize: Dimens.fontSizeTwenty),
          ),
          const Gap(Dimens.spaceSmall),
          Container(
            padding: const EdgeInsets.all(Dimens.spaceMedium),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(Dimens.radiusMedium)),
            child: Column(
              children: Localization.localizations
                  .map((Localization language) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: Dimens.space2xSmall),
                        child: AppCheckbox(
                          value:
                              bloc.state.selectedLanguageCode == language.code,
                          itemText: language.name.toString(),
                          onChanged: (p0) => bloc.add(LanguageTapEvent(
                              languageCode: language.code,
                              localization: language)),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
