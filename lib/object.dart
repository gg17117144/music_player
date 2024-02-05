import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class GifObject extends StatelessWidget {
  final String image;
  final GifController controller;
  // final Function() onTap;

  const GifObject({super.key, required this.image, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Gif(
      controller: controller,
      image: AssetImage(image),
      autostart: Autostart.loop,
      placeholder: (context) =>
      const Center(child: CircularProgressIndicator()),
      height: 200,
      width: 200,
    );
  }
}

