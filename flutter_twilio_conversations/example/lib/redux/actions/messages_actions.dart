import 'dart:io';

import 'package:flutter_twilio_conversations_platform_interface/flutter_twilio_conversations_platform_interface.dart';

class GetConversationMessagesAction {
  final Channel channel;

  GetConversationMessagesAction(this.channel);
}

class UpdateChatMessagesAction {
  final List<Message> messages;

  UpdateChatMessagesAction(this.messages);
}

class SendTextMessageAction {
  final Channel channel;
  final String text;

  SendTextMessageAction(this.channel, this.text);
}

class SendImageAction {
  final Channel channel;
  final File image;

  SendImageAction(this.channel, this.image);
}
