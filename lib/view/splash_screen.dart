
import 'package:get/get.dart';
import 'movies_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:movies_task/utils/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  Future<void> gotoHome() async {
    await Future.delayed(Duration(seconds: 3), () {
      Get.to(() => MoviesListWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(ImageAssets.splashImage, fit: BoxFit.fill)
        ),
      ),
    );
  }
}
