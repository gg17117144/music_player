import 'package:flutter/material.dart';


class CustomBody extends StatelessWidget {
  final String pageName;

  const CustomBody(this.pageName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(pageName,style: const TextStyle(color: Colors.white, fontSize: 36),),
        ],
      ),
    );
  }
}