import 'package:flutter/material.dart';
import 'package:pchat/components/auth_services.dart';
import 'package:pchat/components/my_drawer.dart';
import 'package:pchat/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});
  final _chatServices = ChatServices();
  final _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Home")),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(stream: _chatServices.getUserStream(), builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading..");
      }
      return ListView(
        children: [

        ],
      );
    });
  }
}
