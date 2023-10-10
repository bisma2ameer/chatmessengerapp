import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/message.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGES
  Future<void> sendMessage(String receiverId, String messageTxt) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: messageTxt,
        timestamp: timestamp, reactions: ["\u{1F604}", "\u{1F601}", "\u{1F602}", "\u{1F607}"]);

    
    //construct chat room id from current user id & receiver id (to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort is imp , sort the ids to esnure chat room id is same for any pair of users
    String chatRoomId = ids
        .join("_"); //combine the ids into single string to use as a chatroomID

    //add new messages to the database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chat room from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  void addReaction(param0, String reaction) {}
}
