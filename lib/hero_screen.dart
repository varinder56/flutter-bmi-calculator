import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});
  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'sun',
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(60),
            child: Image.asset("assets/images/sunshineLogo.png"),
          ),
        ),
      ),
    );
  }
}
