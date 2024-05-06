import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../platform_interface/flutter_twilio_conversations_platform.dart';
import '../types/parts.dart';
// const MethodChannel _channel =
//     MethodChannel('plugins.flutter.io/flutter_twilio_conversations');

/// An implementation of [FlutterTwilioConversationsPlatform] that uses method channels.
class MethodChannelFlutterTwilioConversations
    extends FlutterTwilioConversationsPlatform {
  // @visibleForTesting
  // MethodChannel get channel => _channel;
  final MethodChannel _methodChannel;

  MethodChannelFlutterTwilioConversations()
      : _methodChannel = MethodChannel('flutter_twilio_conversations'),
        super();

  /// This constructor is only used for testing and shouldn't be accessed by
  /// users of the plugin. It may break or change at any time.
  @visibleForTesting
  MethodChannelFlutterTwilioConversations.private(
    this._methodChannel,
  );

  @override
  Future<ChatClient?> create(String token, Properties properties) async {
    print('here');
    return _methodChannel.invokeMethod("create");
  }
}
