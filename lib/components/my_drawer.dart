import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pchat/components/auth_services.dart';
import 'package:pchat/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    final auth = AuthServices();
    auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
           children: [
             DrawerHeader(
               child: Center(
                 child: Icon(
                   Icons.message,
                   color: Theme.of(context).colorScheme.primary,
                   size: 40,
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 28.0),
               child: ListTile(
                 title: Text("H O M E"),
                 leading: Icon(Icons.home,color: Theme.of(context).colorScheme.primary,),
                 onTap: (){Navigator.pop(context);},
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 28.0),
               child: ListTile(
                 title: Text("S E T T I N G"),
                 leading: Icon(Icons.home,color: Theme.of(context).colorScheme.primary,),
                 onTap: (){
                   Navigator.pop(context);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
                 },
               ),
             ),
           ],
         ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0,bottom: 25),
            child: ListTile(

              title: Text("L O G O U T"),
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.primary,),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
