import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desk360flutter/desk360flutter.dart';
import 'package:desk360flutter/enums/errorcodes.dart';
import 'package:desk360flutter/enums/environments.dart';
import 'package:desk360flutter/enums/platforms.dart';

void main() {
  const MethodChannel channel = MethodChannel('desk360flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'start':
          return null;
        case 'getTicketId':
          return 'test-ticket-id';
        case 'getUnreadTickets':
          return [];
        case 'showWithPushDeeplink':
          return null;
        case 'ticketDetailsViewController':
          return null;
        case 'showDetails':
          return null;
        case 'setPushToken':
          return null;
        case 'applicationLaunchChecker':
          return null;
        case 'willNotificationPresent':
          return null;
        case 'applicationUserInfoChecker':
          return null;
        case 'initialize':
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('Desk360flutter Tests', () {
    test('should start without properties', () async {
      expect(() async => await Desk360flutter.start(), returnsNormally);
    });

    test('should start with valid properties', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 0,
      };
      expect(() async => await Desk360flutter.start(properties: properties), returnsNormally);
    });

    test('should throw exception for null appID', () async {
      final properties = {
        'appID': null,
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.start(properties: properties),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for empty appID', () async {
      final properties = {
        'appID': '',
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.start(properties: properties),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for invalid environment', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 2, // Invalid value
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.start(properties: properties),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for invalid platform', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 2, // Invalid value
      };
      expect(
        () async => await Desk360flutter.start(properties: properties),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should show with animated parameter', () async {
      expect(() async => await Desk360flutter.show(animated: true), returnsNormally);
    });

    test('should show with default animated parameter', () async {
      expect(() async => await Desk360flutter.show(), returnsNormally);
    });

    test('should set push token', () async {
      expect(() async => await Desk360flutter.setPushToken('test-token'), returnsNormally);
    });

    test('should get ticket id', () async {
      final result = await Desk360flutter.getTicketId();
      expect(result, equals('test-ticket-id'));
    });

    test('should get unread tickets', () async {
      final result = await Desk360flutter.getUnreadTickets();
      expect(result, isA<List>());
    });

    test('should show with push deeplink', () async {
      expect(() async => await Desk360flutter.showWithPushDeeplink(), returnsNormally);
    });

    test('should show ticket details view controller', () async {
      final ticket = {'id': 'test-ticket', 'title': 'Test Ticket'};
      expect(() async => await Desk360flutter.ticketDetailsViewController(ticket, animated: true), returnsNormally);
    });

    test('should show details', () async {
      final ticket = {'id': 'test-ticket', 'title': 'Test Ticket'};
      expect(() async => await Desk360flutter.showDetails(ticket, animated: true), returnsNormally);
    });

    test('should handle application launch checker', () async {
      final launchOptions = {'key': 'value'};
      expect(() async => await Desk360flutter.applicationLaunchChecker(launchOptions), returnsNormally);
    });

    test('should handle will notification present', () async {
      final userInfo = {'notification': 'data'};
      expect(() async => await Desk360flutter.willNotificationPresent(userInfo), returnsNormally);
    });

    test('should handle application user info checker', () async {
      final launchOptions = {'key': 'value'};
      expect(() async => await Desk360flutter.applicationUserInfoChecker(launchOptions), returnsNormally);
    });

    test('should initialize with valid parameters', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', 'test-device-id'),
        returnsNormally,
      );
    });

    test('should initialize with null notification token', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, null, 'test-device-id'),
        returnsNormally,
      );
    });

    test('should throw exception for empty deviceId in initialize', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', ''),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for empty appID in initialize', () async {
      final properties = {
        'appID': '',
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', 'test-device-id'),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for null appID in initialize', () async {
      final properties = {
        'appID': null,
        'environment': 0,
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', 'test-device-id'),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for invalid environment in initialize', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 2, // Invalid value
        'platform': 0,
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', 'test-device-id'),
        throwsA(isA<Desk360FlutterException>()),
      );
    });

    test('should throw exception for invalid platform in initialize', () async {
      final properties = {
        'appID': 'test-app-id',
        'environment': 0,
        'platform': 2, // Invalid value
      };
      expect(
        () async => await Desk360flutter.initialize(properties, 'test-token', 'test-device-id'),
        throwsA(isA<Desk360FlutterException>()),
      );
    });
  });

  group('ErrorCode Tests', () {
    test('should create exception with valid error code', () {
      final exception = Desk360FlutterException(ErrorCode.PROPERTIES_APPID_REQUIRED);
      expect(exception.code, equals(201));
      expect(exception.message, contains('Missing parameter "appID"'));
    });

    test('should handle all error codes', () {
      for (final errorCode in ErrorCode.values) {
        final exception = Desk360FlutterException(errorCode);
        expect(exception.code, isA<int>());
        expect(exception.message, isA<String>());
        expect(exception.code, greaterThan(0));
        expect(exception.message, isNotEmpty);
      }
    });

    test('should have unique error codes', () {
      final codes = <int>{};
      for (final errorCode in ErrorCode.values) {
        final exception = Desk360FlutterException(errorCode);
        expect(codes.add(exception.code), isTrue, reason: 'Duplicate error code: ${exception.code}');
      }
    });
  });

  group('Environment Tests', () {
    test('should have correct values', () {
      expect(Environment.SANDBOX.value, equals(0));
      expect(Environment.PRODUCTION.value, equals(1));
    });

    test('should have all enum values', () {
      expect(Environment.values.length, equals(2));
      expect(Environment.values.contains(Environment.SANDBOX), isTrue);
      expect(Environment.values.contains(Environment.PRODUCTION), isTrue);
    });
  });

  group('Platform Tests', () {
    test('should have correct values', () {
      expect(Platform.GOOGLE.value, equals(0));
      expect(Platform.HUAWEI.value, equals(1));
    });

    test('should have all enum values', () {
      expect(Platform.values.length, equals(2));
      expect(Platform.values.contains(Platform.GOOGLE), isTrue);
      expect(Platform.values.contains(Platform.HUAWEI), isTrue);
    });
  });
}
