import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/extension_imports.dart';
import 'package:flutter_base_architecture_plugin/imports/utils_imports.dart';

import 'blocs/main_app/main_app_bloc.dart';
import 'blocs/main_app/main_app_contract.dart';
import 'core/colors.dart';
import 'core/constants.dart';
import 'localization/app_localization.dart';
import 'ui/common/app_loader.dart';
import 'ui/common/app_toast.dart';
import 'ui/common/confirmation_alert_dialog.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends BaseState<MainAppBloc, EntryPoint>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    navigatorKey = GlobalKey<NavigatorState>();
    middleware = NavigatorMiddleware<PageRoute>(
      onPush: (route, previousRoute) {
        currentRouteName = route.settings.name ?? '';
        debugPrint('#### Route Name : ${route.settings.name ?? ''}');
      },
      onReplace: (route, previousRoute) {
        currentRouteName = route.settings.name ?? '';
        debugPrint('#### Route Name : ${route.settings.name ?? ''}');
      },
      onPop: (route, previousRoute) {
        currentRouteName = previousRoute?.settings.name ?? '';
        debugPrint('#### Route Name : ${route.settings.name ?? ''}');
      },
      onRemove: (route, previousRoute) {
        currentRouteName = previousRoute?.settings.name ?? '';
        debugPrint('#### Route Name : ${route.settings.name ?? ''}');
      },
    );
    WidgetsBinding.instance.addObserver(this);
    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAppBloc>(
      create: (BuildContext context) => bloc,
      child: BlocBuilder<MainAppBloc, MainAppData>(
        builder: (BuildContext context, MainAppData data) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(color: AppColors.white),
                radioTheme: RadioThemeData(
                    visualDensity: VisualDensity.compact,
                    fillColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.primaryBlue1))),
            home: _MainContent(bloc: bloc),
            debugShowCheckedModeBanner: false,
            supportedLocales: AppConstants.localizationList.toLocaleList(),
          );
        },
      ),
    );
  }

  @override
  void onViewEvent(ViewAction event) {
    switch (event.runtimeType) {
      case const (ChangeTheme):
        _forceRebuildWidgets();
        break;
      case const (DisplayMessage):
        buildHandleMessage(event as DisplayMessage);
        break;
      case const (NavigateScreen):
        buildHandleActionEvent(event as NavigateScreen);
        break;
      case const (CloseScreen):
        navigatorKey.currentContext?.maybePop();
        break;
    }
  }

  void buildHandleMessage(DisplayMessage displayMessage) {
    final message = displayMessage.message;
    final type = displayMessage.type;
    switch (type) {
      case DisplayMessageType.toast:
        context.showToast(AppToast(message: message!));
        break;
      case DisplayMessageType.dialog:
        showDialog(
          context: context,
          builder: (BuildContext context) => AppAlertDialog(
            message: message ?? '',
            positiveButtonTitle:
                AppLocalization.currentLocalization().ok.toUpperCase(),
          ),
        );
        break;
      default:
        break;
    }
  }

  void buildHandleActionEvent(NavigateScreen screen) async {
    switch (screen.target) {
      // TODO
      /*case AppRoutes.loginScreen:
        navigatorKey.currentContext?.pushAndRemoveUntil(
          settings: RouteSettings(name: screen.target),
          builder: (_) => const LoginScreen(),
        );
        break;*/
    }
  }

  void _forceRebuildWidgets() {
    void rebuild(Element widget) {
      widget.markNeedsBuild();
      widget.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      bloc.add(DisposeEvent());
    } else if (state == AppLifecycleState.inactive) {
      bloc.add(InActiveEvent());
    } else if (state == AppLifecycleState.resumed) {
      bloc.add(AppResumedEvent());
    }
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.bloc});

  final MainAppBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.state.state) {
      case ScreenState.loading:
        return const AppLoader();
      case ScreenState.content:
        return Center(child: Text('Home Screen'));
      /*(bloc.state.isLoggedIn! || bloc.state.isGuestUser)
            ? const TabBarScreen()
            : const LanguageSelectionScreen();*/
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}