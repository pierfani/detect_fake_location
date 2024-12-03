// import 'detect_fake_location_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class DetectFakeLocation {
  static const mothodChannel = MethodChannel('detect_fake_location');

  Future<bool> detectFakeLocation() async {
    return await mothodChannel.invokeMethod('detectFakeLocation');
    //TODO ripristinare il controllo dei permessi.
    //// Eliminato temporanemente perchè restituisce sempre denied
    bool result = false;
    if (await Permission.location.isGranted) {
      result = await mothodChannel.invokeMethod('detectFakeLocation');
      return result;
    } else {
      PermissionStatus status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        result = await mothodChannel.invokeMethod('detectFakeLocation');
        return result;
      } else if (status == PermissionStatus.permanentlyDenied) {
        return false;
      } else {
        return false;
      }
    }
  }
}
