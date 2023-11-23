import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled09/chat/chatservice.dart';
import 'package:untitled09/components/mytextfield.dart';

import '../components/chatbubble.dart';
class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage()async {
    //only send message if there is something to send
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      //clear the text controller after sending the message
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(
        children: [
          //messages
          Expanded(
              child:_buildMessageList()
          ),
          //user Input
          _buildMessageInput(),
        ],
      ),
    );
  }
  //build msg list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,_firebaseAuth.currentUser!.uid),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs.map((document)=> _buildMessageItem(document)).toList(),
        );
      }

    );
  }
//build msg item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic>data = document.data() as Map<String,dynamic>;
    //align the message to the right if the sender is the current user,otherwise to the left
    var alignment = (data['senderId']==_firebaseAuth.currentUser!.uid)
    ?Alignment.centerRight
        :Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment:alignment,
        child: Column(
          crossAxisAlignment:  (data['senderId']==_firebaseAuth.currentUser!.uid)
            ?CrossAxisAlignment.end
          :CrossAxisAlignment.start,
          mainAxisAlignment:(data['senderId']==_firebaseAuth.currentUser!.uid)
            ?MainAxisAlignment.end
          :MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 10),
            ChatBubble(message:data['message']),
          ],
        ),
      ),
    );

  }
//build msg input
      Widget _buildMessageInput(){
    return Row(
      children: [
        //textfield
        Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter message',
              obscureText: false,
            ),
        ),
        //send button
        IconButton(onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward,size: 40,),
        ),
      ],
    );
      }
}
