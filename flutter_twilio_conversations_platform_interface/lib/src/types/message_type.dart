part of flutter_twilio_conversations_platform_interface;


/// Represents the type of message.
enum MessageType {
  /// [Message] is a regular text message.
  TEXT,

  /// [Message] is a media message.
  ///
  /// [Message.media] will return the associated media object.
  MEDIA,
}
