import 'package:flutter_base_architecture_plugin/core/base_bloc.dart';
import 'package:flutter_base_architecture_plugin/core/network/network_info.dart';
import 'package:flutter_base_architecture_plugin/core/screen_state.dart';
import 'package:flutter_base_architecture_plugin/core/view_actions.dart';

import 'full_screen_error_contractor.dart';

class FullScreenErrorBloc
    extends BaseBloc<FullScreenErrorEvent, FullScreenErrorData> {
  FullScreenErrorBloc(this._networkInfoImpl) : super(initState) {
    on<UpdateFullScreenErrorState>((event, emit) => emit(event.state));
    _observeNetworkChange();
  }

  final NetworkInfoImpl _networkInfoImpl;

  static FullScreenErrorData get initState =>
      (FullScreenErrorDataBuilder()..state = ScreenState.content).build();

  void _observeNetworkChange() {
    _networkInfoImpl.onConnectivityChanged.listen((_) async {
      if (await _networkInfoImpl.isConnected) {
        dispatchViewEvent(
            NavigateScreen(FullScreenErrorTarget.NETWORK_RESTORED));
      }
    });
  }
}
