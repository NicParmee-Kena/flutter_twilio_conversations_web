import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../platform_interface/flutter_twilio_conversations_platform.dart';

/// An implementation of [FlutterTwilioConversationsPlatform] that uses method channels.
class MethodChannelFlutterTwilioConversations
    extends FlutterTwilioConversationsPlatform {
  final MethodChannel _methodChannel;
  final EventChannel _chatChannel;

  MethodChannelFlutterTwilioConversations()
      : _methodChannel = MethodChannel('flutter_twilio_conversations'),
        _chatChannel = EventChannel('flutter_twilio_conversations/room'),
        super();

  /// This constructor is only used for testing and shouldn't be accessed by
  /// users of the plugin. It may break or change at any time.
  @visibleForTesting
  MethodChannelFlutterTwilioConversations.private(
    this._methodChannel,
    this._chatChannel,
  );

  @override
  Future<dynamic> createChatClient(
      String token, Map<String, Object> properties) async {
    return _methodChannel.invokeMethod(
        'create', <String, Object>{'token': token, 'properties': properties});
  }

  @override
  Future<void> updateToken(String token) async {
    return await _methodChannel.invokeMethod(
        'ChatClient#updateToken', <String, Object>{'token': token});
  }

  @override
  Future<void> shutdown() async {
    return await _methodChannel.invokeMethod('ChatClient#shutdown', null);
  }

  Future<Map<dynamic, dynamic>> createChannel(
      String friendlyName, String channelType) async {
    return await _methodChannel.invokeMethod(
        'Channels#createChannel', <String, Object>{
      'friendlyName': friendlyName,
      'channelType': channelType
    });
  }

  Future<dynamic> getChannelUserDescriptors(String channelSid) async {
    return await _methodChannel.invokeMethod(
        'Users#getChannelUserDescriptors', {'channelSid': channelSid});
  }

  Future<dynamic> getUserDescriptor(String identity) async {
    return await _methodChannel
        .invokeMethod('Users#getUserDescriptor', {'identity': identity});
  }

  Future<void> unsubscribe(String? identity) async {
    await _methodChannel
        .invokeMethod('User#unsubscribe', {'identity': identity});
  }

  Future<dynamic> getAndSubscribeUser(String identity) async {
    return await _methodChannel
        .invokeMethod('Users#getAndSubscribeUser', {'identity': identity});
  }

  Future<dynamic> getChannel(String channelSidOrUniqueName) async {
    return await _methodChannel.invokeMethod('Channels#getChannel',
        <String, Object>{'channelSidOrUniqueName': channelSidOrUniqueName});
  }

  Future<dynamic> getPublicChannelsList() async {
    return await _methodChannel.invokeMethod('Channels#getPublicChannelsList');
  }

  Future<dynamic> getUserChannelsList() async {
    return await _methodChannel.invokeMethod('Channels#getUserChannelsList');
  }

  Future<dynamic> getMembersByIdentity(String identity) async {
    return await _methodChannel
        .invokeMethod('Channels#getMembersByIdentity', {'identity': identity});
  }

  Future<dynamic> getMember(String channelSid, String identity) async {
    return await _methodChannel.invokeMethod('Members#getMember', {
      'channelSid': channelSid,
      'identity': identity,
    });
  }

  Future<dynamic> getMembersList(String channelSid) async {
    return await _methodChannel.invokeMethod('Members#getMembersList', {
      'channelSid': channelSid,
    });
  }

  Future<bool?> addByIdentity(String channelSid, String identity) async {
    return _methodChannel.invokeMethod('Members#addByIdentity',
        {'identity': identity, 'channelSid': channelSid});
  }

  Future<bool?> removeByIdentity(String channelSid, String identity) async {
    return _methodChannel.invokeMethod('Members#removeByIdentity',
        {'identity': identity, 'channelSid': channelSid});
  }

  Future<bool?> inviteByIdentity(String channelSid, String identity) async {
    return _methodChannel.invokeMethod('Members#inviteByIdentity',
        {'identity': identity, 'channelSid': channelSid});
  }

  Future<dynamic> setAttributesMember(
      String sid, String? channelSid, Map<String, dynamic> attributes) async {
    return _methodChannel.invokeMethod('Member#setAttributes',
        {'memberSid': sid, 'channelSid': channelSid, 'attributes': attributes});
  }

  Future<dynamic> memberGetUserDescriptor(
      String? identity, String? channelSid) async {
    return await _methodChannel.invokeMethod('Member#getUserDescriptor', {
      'identity': identity,
      'channelSid': channelSid,
    });
  }

  Future<dynamic> memberGetAndSubscribeUser(
      String? sid, String? channelSid) async {
    return await _methodChannel.invokeMethod('Member#getAndSubscribeUser', {
      'memberSid': sid,
      'channelSid': channelSid,
    });
  }

  @override
  Future<void> declineInvitationChannel(String channelSid) {
    return _methodChannel
        .invokeMethod('Channel#declineInvitation', {'channelSid': channelSid});
  }

  @override
  Future<void> destroyChannel(String channelSid) {
    return _methodChannel
        .invokeMethod('Channel#destroy', {'channelSid': channelSid});
  }

  @override
  Future<String> getFriendlyNameChannel(String channelSid) async {
    return await _methodChannel
        .invokeMethod('Channel#getFriendlyName', {'channelSid': channelSid});
  }

  @override
  Future<int> getMembersCountChannel(String channelSid) async {
    return await _methodChannel
        .invokeMethod('Channel#getMembersCount', {'channelSid': channelSid});
  }

  @override
  Future<int> getMessagesCount(String channelSid) async {
    return await _methodChannel
        .invokeMethod('Channel#getMessagesCount', {'channelSid': channelSid});
  }

  @override
  Future<String> getNotificationLevelChannel(String channelSid) async {
    return await _methodChannel.invokeMethod(
        'Channel#getNotificationLevel', {'channelSid': channelSid});
  }

  @override
  Future<String> getUniqueNameChannel(String channelSid) async {
    return await _methodChannel
        .invokeMethod('Channel#getUniqueName', {'channelSid': channelSid});
  }

  Future<void> removeMessage(String channelSid, int messageIndex) async {
    await _methodChannel.invokeMethod('Messages#removeMessage',
        {'channelSid': channelSid, 'messageIndex': messageIndex});
  }

  @override
  Future<int> getUnreadMessagesCount(String channelSid) async {
    return await _methodChannel.invokeMethod(
            'Channel#getUnreadMessagesCount', {'channelSid': channelSid}) ??
        0;
  }

  @override
  Future<int?> setLastReadMessageIndexWithResult(
      String channelSid, int lastReadMessageIndex) async {
    return await _methodChannel.invokeMethod(
        'Messages#setLastReadMessageIndexWithResult', {
      'channelSid': channelSid,
      'lastReadMessageIndex': lastReadMessageIndex
    });
  }

  @override
  Future<int?> advanceLastReadMessageIndexWithResult(
      String channelSid, int lastReadMessageIndex) async {
    return await _methodChannel.invokeMethod(
        'Messages#advanceLastReadMessageIndexWithResult', {
      'channelSid': channelSid,
      'lastReadMessageIndex': lastReadMessageIndex
    });
  }

  Future<int?> setNoMessagesReadWithResult(String channelSid) async {
    return _methodChannel.invokeMethod(
        'Messages#setNoMessagesReadWithResult', {'channelSid': channelSid});
  }

  @override
  Future<void> joinChannel(String channelSid) {
    return _methodChannel
        .invokeMethod('Channel#join', {'channelSid': channelSid});
  }

  @override
  Future<void> leaveChannel(String channelSid) {
    return _methodChannel
        .invokeMethod('Channel#leave', {'channelSid': channelSid});
  }

  @override
  Future<Map<String, dynamic>> setAttributesChannel(
      String channelSid, Map<String, dynamic> attributes) async {
    return await _methodChannel.invokeMethod('Channel#setAttributes',
        {'channelSid': channelSid, 'attributes': attributes});
  }

  @override
  Future<String> setFriendlyNameChannel(
      String channelSid, String friendlyName) async {
    return await _methodChannel.invokeMethod('Channel#setFriendlyName',
        {'channelSid': channelSid, 'friendlyName': friendlyName});
  }

  @override
  Future<String> setNotificationLevelChannel(
      String channelSid, String notificationLevel) async {
    return await _methodChannel.invokeMethod('Channel#setNotificationLevel', {
      'channelSid': channelSid,
      'notificationLevel': notificationLevel,
    });
  }

  @override
  Future<void> handleReceivedNotification() async {
    return await _methodChannel.invokeMethod('handleReceivedNotification');
  }

  Future<String> registerForNotification(
    String token, {
    String? webChannel,
  }) async {
    return await _methodChannel.invokeMethod(
        'registerForNotification', <String, Object>{'token': token});
  }

  Future<void> unregisterForNotification(
    String token, {
    String? webChannel,
  }) async {
    return await _methodChannel.invokeMethod(
        'unregisterForNotification', <String, Object>{'token': token});
  }

  @override
  Future<String> setUniqueNameChannel(
      String channelSid, String uniqueName) async {
    return await _methodChannel.invokeMethod('Channel#setUniqueName',
        {'channelSid': channelSid, 'uniqueName': uniqueName});
  }

  @override
  Future<void> typingChannel(String channelSid) {
    return _methodChannel
        .invokeMethod('Channel#typing', {'channelSid': channelSid});
  }

  @override
  Future<String> updateMessageBody(
      String? channelSid, int? messageIndex, String body) async {
    return await _methodChannel.invokeMethod('Message#updateMessageBody', {
          'channelSid': channelSid,
          'messageIndex': messageIndex,
          'body': body,
        }) ??
        '';
  }

  Future<dynamic> setAttributes(String? channelSid, int? messageIndex,
      Map<String, dynamic> attributes) async {
    return await _methodChannel.invokeMethod('Message#setAttributes', {
      'channelSid': channelSid,
      'messageIndex': messageIndex,
      'attributes': attributes,
    });
  }

  Future<String> getDownloadURL(String channelSid, int messageIndex) async {
    return await _methodChannel.invokeMethod('Message#getMedia', {
      'channelSid': channelSid,
      'messageIndex': messageIndex,
    });
  }

  Future<dynamic> requestNextPage(String pageId, String itemType) async {
    return await _methodChannel.invokeMethod('Paginator#requestNextPage',
        <String, Object>{'pageId': pageId, 'itemType': itemType});
  }

  @override
  Future<dynamic> getMessageByIndex(String channelSid, int messageIndex) async {
    return await _methodChannel.invokeMethod('Messages#getMessageByIndex',
        {'channelSid': channelSid, 'messageIndex': messageIndex});
  }

  @override
  Future<dynamic> getLastMessages(int count, String channelSid) async {
    return await _methodChannel.invokeMethod('Messages#getLastMessages', {
      'count': count,
      'channelSid': channelSid,
    });
  }

  @override
  Future<dynamic> getMessagesAfter(
      int index, int count, String channelSid) async {
    return await _methodChannel.invokeMethod('Messages#getMessagesAfter', {
      'index': index,
      'count': count,
      'channelSid': channelSid,
    });
  }

  @override
  Future<dynamic> getMessagesBefore(
      int index, int count, String channelSid) async {
    return await _methodChannel.invokeMethod('Messages#getMessagesBefore', {
      'index': index,
      'count': count,
      'channelSid': channelSid,
    });
  }

  Future<int?> setAllMessagesReadWithResult(String channelSid) async {
    return await _methodChannel.invokeMethod(
        'Messages#setAllMessagesReadWithResult', {'channelSid': channelSid});
  }

  @override
  Future<dynamic> sendMessage(
      Map<String, dynamic> messageOptions, String channelSid) async {
    return await _methodChannel.invokeMethod('Messages#sendMessage', {
      'options': messageOptions,
      'channelSid': channelSid,
    });
  }

  @override
  Future<void> platformDebug(bool dart, bool native, bool sdk) async {
    return await _methodChannel
        .invokeMethod('debug', {'native': native, 'sdk': sdk});
  }

// needs to be implemented for the mobile interface
  Stream<Map<dynamic, dynamic>>? chatClientStream() {
    try {
      return _chatChannel.receiveBroadcastStream().map((event) {
        return event as Map<dynamic, dynamic>;
      });
    } catch (e) {
      return null;
    }
  }

  Stream<Map<dynamic, dynamic>>? channelStream(String sid) {
    try {
      return EventChannel('flutter_twilio_conversations/$sid')
          .receiveBroadcastStream()
          .map((event) {
        return event as Map<dynamic, dynamic>;
      });
    } catch (e) {
      return null;
    }
  }

  Stream<Map<dynamic, dynamic>>? notificationStream() {
    try {
      return EventChannel('flutter_twilio_conversations/notification')
          .receiveBroadcastStream(0)
          .map((event) {
        return event as Map<dynamic, dynamic>;
      });
    } catch (e) {
      return null;
    }
  }
}
