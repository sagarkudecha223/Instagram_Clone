import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:gap/gap.dart';

import '../../core/colors.dart';
import '../../core/dimens.dart';
import '../../core/event_buses.dart';
import '../../core/styles.dart';
import '../../services/hive/model/user_account_hive.dart';
import '../../services/user/user_service.dart';
import '../common/app_loader.dart';
import '../common/buttons/elevated_button.dart';
import '../common/container_decoration.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late UserAccountHive userAccountHive;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    userAccountHive = KiwiContainer().resolve<UserService>().currentUser;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ContainerLinearGradient()),
        alignment: Alignment.center,
        height: double.infinity,
        padding: const EdgeInsets.all(Dimens.spaceLarge),
        child: isLoading
            ? const AppLoader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(Dimens.space5xLarge),
                  const _ProfileIcon(),
                  Expanded(child: _UserInfo(userAccountHive: userAccountHive)),
                  const _LogoutButton(),
                  const Gap(Dimens.space5xLarge),
                ],
              ),
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.space2xMedium),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor)),
      child: const Icon(Icons.person, size: Dimens.icon3xLarge),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserAccountHive userAccountHive;

  const _UserInfo({required this.userAccountHive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CommonTextView(
            label: 'Name', value: userAccountHive.fullName.toString()),
        _CommonTextView(
            label: 'Username', value: userAccountHive.username.toString()),
        _CommonTextView(
            label: 'Mobile Number Or Email',
            value: userAccountHive.mobileOrEmail.toString()),
      ],
    );
  }
}

class _CommonTextView extends StatelessWidget {
  final String label;
  final String value;

  const _CommonTextView({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space4xSmall),
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: value),
        style: AppFontTextStyles.textStyleMedium()
            .copyWith(fontSize: Dimens.fontSizeTwenty),
        decoration: InputDecoration(
            label: Text(
          label,
          style: AppFontTextStyles.textStyleMedium()
              .copyWith(color: AppColors.hintTextColor),
        )),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: 'Logout',
      onTap: () =>
          KiwiContainer().resolve<EventBus>().sendEvent(SignOutBusEvent()),
    );
  }
}
