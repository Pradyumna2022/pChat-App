import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pchat/components/auth_services.dart';
import 'package:pchat/components/my_text_field.dart';
import 'package:pchat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiveEmail, required this.receiverId});
  final _messagesController = TextEditingController();
  final _chatServices = ChatServices();
  final _authServices = AuthServices();
  void sendMessages() async {
    if (_messagesController.text.isNotEmpty) {
      await _chatServices.sentMessages(receiverId, _messagesController.text);
      _messagesController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiveEmail)),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList()),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error in chat ");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data["message"]);
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            hintText: "Enter your messages..",
            obscureText: false,
            controller: _messagesController,
          ),
        ),
        IconButton(onPressed: sendMessages, icon: Icon(Icons.send))
      ],
    );
  }
}
