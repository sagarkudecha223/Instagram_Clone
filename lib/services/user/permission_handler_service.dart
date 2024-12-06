import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  Future<bool> requestPhonePermission() async => await requestPermission(Permission.phone);

  Future<bool> requestPermission(Permission permission) async {
    final previousStatus = await permission.status;
    final status = await permission.request();
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.permanentlyDenied:
        if (previousStatus == status) {
          await openAppSettings();
        }
        return false;
      default:
        return false;
    }
  }
}
