
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

  bool _isRecordingAudio = false;
  bool _isSendingVideo = false;

  Map<String, dynamic>? _selectedMessageData; // Store data of the selected message
  bool _showReactionsMenu = false; // Control the visibility of reactions menu
   final Map<String, String?> _selectedEmojis = {}; 


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
    String messageId = document.id; // Unique identifier for the message

    // Check if a selected emoji is associated with this message
    String? selectedEmoji = _selectedEmojis[messageId];

    return GestureDetector(
      onTap: () {
        // Toggle reactions menu visibility on message click
        // Navigator.of(context).pop('reactions');
        setState(() {
          _selectedMessageData = data;
          _showReactionsMenu = !_showReactionsMenu;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message']),
            const SizedBox(height: 5,),
            // Display selected emoji associated with this message
            if (selectedEmoji != null)
              Text(selectedEmoji, style: const TextStyle(fontSize: 24)),
            // Display emoji reactions when _showReactionsMenu is true
            if (_showReactionsMenu &&
                data['reactions'] != null &&
                data['reactions'].isNotEmpty)
              Wrap(
                spacing: 8, // Adjust spacing as needed
                children: data['reactions'].map<Widget>((reaction) {
                  return GestureDetector(
                    onTap: () {
                      // Handle reaction selection here
                      setState(() {
                        // Associate the selected emoji with this message
                        
                        _selectedEmojis[messageId] = reaction;
                      });
                    },
                    child: Text(reaction, style: const TextStyle(fontSize: 24)),
                  );
                }).toList(),
              ),
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
       // Button for toggling between audio and video
        Padding(
          padding: const EdgeInsets.only(bottom: 13, left: 5),
          child: IconButton(
            onPressed: () {
              setState(() {
                // Toggle between audio and video mode
                if (_isRecordingAudio) {
                  _isRecordingAudio = false;
                  _isSendingVideo = true;
                } else {
                  _isRecordingAudio = true;
                  _isSendingVideo = false;
                }
              });
            },
            icon: _isRecordingAudio
                ? Icon(
                    Icons.videocam_outlined, // Display video icon
                    size: 35,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.mic_outlined, // Display audio icon
                    size: 35,
                    color: Colors.grey,
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
                size: 40,
                color: Colors.grey,
              )),
        ),
      )
    ]);
  }
  
}
