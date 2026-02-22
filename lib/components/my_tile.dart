import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const  MyTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20 ),
        margin: EdgeInsets.symmetric(horizontal:20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.person),
            Text(text)
          ],
        ),
      ),
    );
  }
}
