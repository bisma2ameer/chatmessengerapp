
import 'package:chatmessengerapp/components/chat_bubble.dart';
import 'package:chatmessengerapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiveuserEmail;
  final String reciveUserID;

  const ChatPage(
      {super.key, required this.receiveuserEmail, required this.reciveUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.reciveUserID, _messageController.text);
      //clear controlling after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveuserEmail),
        backgroundColor: Colors.grey[400],
      ),
      body: Column(children: [
        //messages
        Expanded(
          child: _buildMessageList(),
        ),
        //user input
        _buildMessageInput(),
      ]),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.reciveUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loadin...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align messages to right if sender is current user otherwise left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      //if there is no alignment everything will be in the middle
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(children: [
      //textfield
      Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10, right: 0),
          child: MyTextField(
            controller: _messageController,
            hintText: "Enter Message",
            obscureText: false,
          ),
        ),
      ),
      //send message button
      Expanded(
        
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 5),
          child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_forward_outlined,
                size: 50,
                color: Colors.grey,
              )),
        ),
      )
    ]);
  }
}
