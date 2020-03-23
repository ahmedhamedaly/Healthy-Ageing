
import 'package:Healthy_Ageing/models/user_object.dart';

class Message {
  Message(this.author, this.timestamp, this.value, [this.outgoing = false]);

  final User_Object author;
  final DateTime timestamp;
  final String value;
  final bool outgoing; // True if this message was sent by the current user
}