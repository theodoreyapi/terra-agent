import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../menu/menu.dart';
import '../splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadingValue = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _updateLoadingProgress();
    });
  }

  _updateLoadingProgress() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (loadingValue >= 1) {
        _navigateToNextScreen();
        return;
      }
      loadingValue += 0.1;
      setState(() {});
      _updateLoadingProgress();
    });
  }

  Future<void> _navigateToNextScreen() async {
    String? nom = SharedPreferencesHelper().getString('nom');
    if (nom != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      extendBody: true,
      body: Center(
        child: Text(
          AppConstants.appName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: appWhite,
            fontSize: 25.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
      ),
    );
  }
}
