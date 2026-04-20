import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/utils/utils.dart';
import 'package:terra_agent/features/menu/menu.dart';
import 'package:terra_agent/features/splash/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double _loadingValue = 0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 1), _updateLoadingProgress);
  }

  void _updateLoadingProgress() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      if (_loadingValue >= 1.0) {
        _navigateToNextScreen();
        return;
      }
      setState(() => _loadingValue += 0.1);
      _updateLoadingProgress();
    });
  }

  Future<void> _navigateToNextScreen() async {
    if (!mounted) return;
    final String? nom = SharedPreferencesHelper().getString('nom');
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => nom != null ? MenuPage() : IntroPage(),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColor, appColorSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // ── Decorative blurred circles ───────────────────────────────────
            Positioned(
              top: -12.w,
              left: -12.w,
              child: _GlowCircle(size: 55.w, opacity: 0.12),
            ),
            Positioned(
              bottom: -10.w,
              right: -10.w,
              child: _GlowCircle(size: 50.w, opacity: 0.1),
            ),
            Positioned(
              top: 30.h,
              right: -8.w,
              child: _GlowCircle(size: 28.w, opacity: 0.08),
            ),

            // ── Center content ───────────────────────────────────────────────
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / icon
                  AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + _pulseController.value * 0.04,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.work_rounded,
                            color: Colors.white,
                            size: 11.w,
                          ),
                        ),
                      )
                      .animate()
                      .fade(duration: 700.ms)
                      .scale(begin: const Offset(0.6, 0.6)),

                  SizedBox(height: 24),

                  // App name
                  Text(
                        AppConstants.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 200.ms)
                      .slideY(begin: -0.2),

                  SizedBox(height: 6),

                  // Tagline
                  Text(
                    "Votre plateforme emploi",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 15.sp,
                      letterSpacing: 0.8,
                    ),
                  ).animate().fadeIn(duration: 700.ms, delay: 400.ms),
                ],
              ),
            ),

            // ── Bottom loading area ──────────────────────────────────────────
            Positioned(
              bottom: 8.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Percentage
                  Text(
                    "${(_loadingValue * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

                  SizedBox(height: 10),

                  // Progress bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _loadingValue,
                        minHeight: 4,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),

                  SizedBox(height: 16),

                  // Loading dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return AnimatedBuilder(
                        animation: _pulseController,
                        builder: (_, __) {
                          final offset = (i / 3) * 3.14159;
                          final scale =
                              0.6 +
                              0.4 *
                                  ((1 +
                                          _pulseController.value * 3.14159 * 2 -
                                          offset) %
                                      1);
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                            width: 2.w * scale.clamp(0.6, 1.0),
                            height: 2.w * scale.clamp(0.6, 1.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                alpha: 0.4 + 0.6 * scale.clamp(0.0, 1.0),
                              ),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      );
                    }),
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Decorative glow circle
class _GlowCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _GlowCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
