import 'package:flutter/material.dart';


class CustomBody extends StatelessWidget {
  final String pageName;

  const CustomBody(this.pageName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(pageName,style: TextStyle(color: Colors.white, fontSize: 36),),
        ],
      ),
    );
  }
}