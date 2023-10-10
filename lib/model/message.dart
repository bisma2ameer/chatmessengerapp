
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;
  List <String> reactions;
   final String? audioUrl;
  
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this. message,
    required this.timestamp,
    this.audioUrl,
    List <String>? reactions,
     }) : reactions = reactions ?? ["\u{1F604}", "\u{1F601}"] ;


    //convert to map
    // ignore: empty_constructor_bodies
    Map<String, dynamic> toMap() {
      return{
        'senderId': senderId,
        'senderEmail': senderEmail,
        'receiverId': receiverId,
        'message':message,
        'timestamp': timestamp,
        'reactions': reactions,
      };
    }
}