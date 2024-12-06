import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/imports/dart_package_imports.dart';

part 'full_screen_error_contractor.g.dart';

abstract class FullScreenErrorData
    implements Built<FullScreenErrorData, FullScreenErrorDataBuilder> {
  factory FullScreenErrorData(
          [void Function(FullScreenErrorDataBuilder) updates]) =
      _$FullScreenErrorData;

  FullScreenErrorData._();

  ScreenState get state;

  String? get errorMessage;
}

abstract class FullScreenErrorEvent {}

class InitEvent extends FullScreenErrorEvent {}

class UpdateFullScreenErrorState extends FullScreenErrorEvent {
  final FullScreenErrorData state;

  UpdateFullScreenErrorState(this.state);
}

abstract class FullScreenErrorTarget {
  static const String NETWORK_RESTORED = 'network_restored';
}
