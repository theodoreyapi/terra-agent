import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../auth/auth.dart';

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
    if (role != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Container()),
        // Remplacer par Home
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
    return Scaffold(
      body: AnimatedContainer(
        duration: 500.ms, // petite animation fluide
        color: demoData[_pageIndex].bgColor,
        child: Column(
          children: [
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
                  return TestScreenContent(
                    images: data.images,
                  ).animate().fade(duration: 600.ms).slideY(begin: 0.1);
                },
              ),
            ),
            Gap(2.h),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: appWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.w),
                    topRight: Radius.circular(6.w),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      demoData[_pageIndex].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: appColorBlack,
                      ),
                    ),
                    Gap(2.h),
                    SubmitButton(
                      AppConstants.btnRegister,
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage()),
                      ),
                    ),
                    Gap(2.w),
                    CancelButton(
                      AppConstants.btnLogin,
                      textcouleur: appColor,
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      ),
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          ),
                          child: Text(
                            "PASSER",
                            style: TextStyle(color: appColorSecondary),
                          ),
                        ),
                        Spacer(),
                        ...List.generate(
                          _nbreSlides,
                          (index) => AnimatedContainer(
                            duration: 300.ms,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: 8,
                            width: _pageIndex == index ? 20 : 10,
                            decoration: BoxDecoration(
                              color: _pageIndex == index
                                  ? appColor
                                  : appColorSecondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            if (_pageIndex + 1 < _nbreSlides) {
                              _pageController.nextPage(
                                curve: Curves.easeInOut,
                                duration: 400.ms,
                              );
                            }
                          },
                          child: Text(
                            "SUIVANT",
                            style: TextStyle(color: appColor),
                          ),
                        ),
                      ],
                    ),
                    Gap(2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestScreenContent extends StatelessWidget {
  const TestScreenContent({super.key, required this.images});

  final String images;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(images, fit: BoxFit.contain, width: 80.w),
      ),
    );
  }
}

class Onboard {
  final String title, images;
  MaterialAccentColor bgColor;

  Onboard({required this.title, required this.images, required this.bgColor});
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
    images: "assets/images/three.png",
    title: "Commencez maintenant et profitez, c'est gratuit",
    bgColor: Colors.purpleAccent,
  ),
];
