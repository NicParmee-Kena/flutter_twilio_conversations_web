import 'package:flutter_twilio_conversations_platform_interface/flutter_twilio_conversations_platform_interface.dart';
class TypingStarted {
  final TypingEvent event;

  TypingStarted(this.event);
}

class TypingEnded {
  final TypingEvent event;

  TypingEnded(this.event);
}
