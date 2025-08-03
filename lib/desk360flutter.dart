import 'dart:async';

import 'package:desk360flutter/enums/errorcodes.dart';
import 'package:flutter/services.dart';

class Desk360flutter {
  static const MethodChannel _channel = MethodChannel('desk360flutter');

  static Future<void> start({Map<String, dynamic>? properties}) async {
    if (properties != null) {
      if ((properties["appID"] as String?)?.isEmpty ?? true) {
        throw Desk360FlutterException(ErrorCode.PROPERTIES_APPID_REQUIRED);
      }
      if (properties["environment"] != null &&
          (properties["environment"] as int?)! > 1) {
        throw Desk360FlutterException(
            ErrorCode.VALIDATE_ENVIRONMENT_NOT_VALID);
      }
      if (properties["platform"] != null &&
          (properties["platform"] as int?)! > 1) {
        throw Desk360FlutterException(
            ErrorCode.VALIDATE_PLATFORM_NOT_VALID);
      }
      await _channel.invokeMethod('start', {"properties": properties});
    } else {
      await _channel.invokeMethod('start');
    }
  }

  //ios only
  static Future<void> show({bool animated = false}) async {
    await _channel.invokeMethod('show', {"animated": animated});
  }

  //ios only
  static Future<void> setPushToken(String deviceToken) async {
    await _channel.invokeMethod('setPushToken', {"deviceToken": deviceToken});
  }

  //ios only
  static Future<void> applicationLaunchChecker(Map<String, dynamic> launchOptions) async {
    await _channel.invokeMethod(
        'applicationLaunchChecker', {"launchOptions": launchOptions});
  }

  //ios only
  static Future<void> willNotificationPresent(Map<String, dynamic> userInfo) async {
    await _channel
        .invokeMethod('willNotificationPresent', {"userInfo": userInfo});
  }

  //ios only
  static Future<void> applicationUserInfoChecker(Map<String, dynamic> launchOptions) async {
    await _channel.invokeMethod(
        'applicationUserInfoChecker', {"launchOptions": launchOptions});
  }

  //ios only
  static Future<void> showWithPushDeeplink() async {
    await _channel.invokeMethod('showWithPushDeeplink');
  }

  //ios only
  static Future<dynamic> getUnreadTickets() async {
    final tickets = await _channel.invokeMethod('getUnreadTickets');
    return tickets;
  }

  //ios only
  static Future<void> ticketDetailsViewController(Map<String, dynamic> ticket, {bool animated = false}) async {
    await _channel.invokeMethod('ticketDetailsViewController',
        {"ticket": ticket, "animated": animated});
  }

  //ios only
  static Future<void> showDetails(Map<String, dynamic> ticket, {bool animated = false}) async {
    await _channel
        .invokeMethod('showDetails', {"ticket": ticket, "animated": animated});
  }

  //android only
  static Future<dynamic> getTicketId() async {
    final ticketId = await _channel.invokeMethod('getTicketId');
    return ticketId;
  }

  //android only
  static Future<void> initialize(Map<String, dynamic> properties, String? notificationToken, String deviceId) async {
    if ((properties['appID'] as String?)?.isEmpty ?? true) {
      throw Desk360FlutterException(ErrorCode.PROPERTIES_APPID_REQUIRED);
    }
    if (properties["environment"] == null ||
        (properties["environment"] != null &&
            (properties["environment"] as int?)! > 1)) {
      throw Desk360FlutterException(
          ErrorCode.VALIDATE_ENVIRONMENT_NOT_VALID);
    }
    if (properties["platform"] == null ||
        (properties["platform"] != null &&
            (properties["platform"] as int?)! > 1)) {
      throw Desk360FlutterException(ErrorCode.VALIDATE_PLATFORM_NOT_VALID);
    }
    if (deviceId.isEmpty) {
      throw Desk360FlutterException(ErrorCode.DEVICE_TOKEN_REQUIRED);
    }
    await _channel.invokeMethod('initialize', {
      "properties": properties,
      "notificationToken": notificationToken,
      "deviceId": deviceId
    });
  }
}
