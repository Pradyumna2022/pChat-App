import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pchat/model/message_model.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //sent messages
  Future<void> sentMessages(String receiveId, message) async {
    // current user info..
    final String currentUid = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();
    MessageModel newMessage = MessageModel(
      senderId: currentUid,
      senderEmail: currentUserEmail,
      receiverId: receiveId,
      message: message,
      timeStamp: timeStamp,
    );
    List<String> ids = [currentUid, receiveId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get Messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
