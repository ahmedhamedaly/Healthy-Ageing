

import 'package:Healthy_Ageing/models/chat_repo.dart';
import 'package:Healthy_Ageing/models/message.dart';

class MessageService{

  Future sendMessage(String chatroomId, String text) async{
    final User user = await UserRepo.getInstance().getCurrentUser();
    final bool success = await ChatRepo.getInstance().sendMessageToChatroom(chatroomId, user, text);
    if (!success) {
      dispatch(MessageSendErrorEvent());
    }
  }

  Future getMessages() async{
    final User user = await UserRepo.getInstance().getCurrentUser();
    chatroomSubscription = ChatRepo.getInstance().getMessagesForChatroom(chatroomId).listen((chatroom) {
      if (chatroom != null) {
        List<Message> processedMessages = chatroom.messages
            .map((message) => Message(
            message.author, message.timestamp, message.value, message.author.uid == user.uid))
            .toList();
        dispatch(MessageReceivedEvent(processedMessages));
      }
    });
  }

}