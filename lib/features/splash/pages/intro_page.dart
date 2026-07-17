import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../auth/auth.dart';
import '../../menu/menu.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int _pageIndex = 0;
  late int _nbreSlides;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => checkLogin());
    _pageController = PageController(initialPage: 0);
    _nbreSlides = demoData.length;
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString("role");
    if (role != null && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Container()),
            (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = demoData[_pageIndex];

    return Scaffold(
      body: AnimatedContainer(
        duration: 500.ms,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              current.bgColor,
              current.bgColor.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header skip button ──────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => MenuPage()),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 0.8.h),
                    ),
                    child: Text(
                      "PASSER",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Illustration area ───────────────────────────────────
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _pageIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final data = demoData[index];
                    // ✅ FIX: Removed Expanded from inside TestScreenContent
                    // so it works correctly inside PageView's builder
                    return OnboardIllustration(images: data.images)
                        .animate()
                        .fade(duration: 600.ms)
                        .slideY(begin: 0.08, curve: Curves.easeOut);
                  },
                ),
              ),

              Container(
                width: double.infinity,
                padding:
                EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dot indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _nbreSlides,
                            (index) => AnimatedContainer(
                          duration: 300.ms,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          height: 8,
                          width: _pageIndex == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _pageIndex == index
                                ? current.bgColor
                                : current.bgColor.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    Gap(2.5.h),

                    // Title
                    AnimatedSwitcher(
                      duration: 400.ms,
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: Text(
                        current.title,
                        key: ValueKey(_pageIndex),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: appColorBlack,
                          height: 1.4,
                        ),
                      ),
                    ),

                    Gap(3.h),

                    // Register button
                    SubmitButton(
                      AppConstants.btnRegister,
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage()),
                      ),
                    ),

                    Gap(1.5.h),

                    // Login button
                    CancelButton(
                      AppConstants.btnLogin,
                      textcouleur: appColor,
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      ),
                    ),

                    Gap(2.h),

                    // Next button
                    if (_pageIndex + 1 < _nbreSlides)
                      TextButton.icon(
                        onPressed: () {
                          _pageController.nextPage(
                            curve: Curves.easeInOut,
                            duration: 400.ms,
                          );
                        },
                        icon: Icon(Icons.arrow_forward_rounded,
                            color: appColorSecondary, size: 18),
                        label: Text(
                          "SUIVANT",
                          style: TextStyle(
                            color: appColorSecondary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),

                    Gap(1.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardIllustration extends StatelessWidget {
  const OnboardIllustration({super.key, required this.images});

  final String images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Image.asset(
          images,
          fit: BoxFit.contain,
          width: 75.w,
        ),
      ),
    );
  }
}

class Onboard {
  final String title, images;
  final MaterialAccentColor bgColor;

  const Onboard({
    required this.title,
    required this.images,
    required this.bgColor,
  });
}

final List<Onboard> demoData = [
  Onboard(
    images: "assets/images/one.png",
    title: "Le travail vous trouve désormais chez vous",
    bgColor: Colors.blueAccent,
  ),
  Onboard(
    images: "assets/images/two.png",
    title: "Travaillez avec de grandes marques",
    bgColor: Colors.greenAccent,
  ),
  Onboard(
    images: "assets/images/three.png",
    title: "Obtenez des missions très bien rémunérées",
    bgColor: Colors.orangeAccent,
  ),
  Onboard(
    images: "assets/images/four.png",
    title: "Commencez maintenant et profitez, c'est gratuit",
    bgColor: Colors.purpleAccent,
  ),
];