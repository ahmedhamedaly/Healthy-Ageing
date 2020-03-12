
class Message {
  Message(this.timestamp, this.value, [this.outgoing = false]);

  final DateTime timestamp;
  final String value;
  final bool outgoing; // True if this message was sent by the current user
}