import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import '../auth.dart';

class CodeOtpPage extends StatefulWidget {
  final String? phone;

  const CodeOtpPage({super.key, this.phone});

  @override
  State<CodeOtpPage> createState() => _CodeOtpPageState();
}

class _CodeOtpPageState extends State<CodeOtpPage> {
  final _formKey = GlobalKey<FormState>();
  String? otp;

  late final TextEditingController pinController;

  // ── Countdown timer ──────────────────────────────────────────────────────────
  static const _totalSeconds = 60;
  int _remainingSeconds = _totalSeconds;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _remainingSeconds = _totalSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds == 0) {
        t.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  String get _timerLabel {
    final m = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── Pin themes ─────────────────────────────────────────────────────────────
    final defaultPinTheme = PinTheme(
      width: 14.w,
      height: 14.w,
      textStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: appColor,
      ),
      decoration: BoxDecoration(
        color: appColorGrey,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.transparent, width: 1.8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appColor, width: 1.8),
      borderRadius: BorderRadius.circular(3.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: appColor.withValues(alpha: 0.1),
        border: Border.all(color: appColor.withValues(alpha: 0.4), width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: [
          // ── Decorative circles ──────────────────────────────────────────────
          Positioned(
            top: -5.w,
            right: -10.w,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            left: -8.w,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar ────────────────────────────────────────────────────
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 5.w,
                          ),
                        ),
                      ).animate().fade(duration: 400.ms),
                      Gap(3.w),
                      Text(
                        AppConstants.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ).animate().fadeIn(duration: 500.ms),
                    ],
                  ),
                ),

                Gap(3.h),

                // ── SMS icon illustration ──────────────────────────────────────
                Center(
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_read_rounded,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  )
                      .animate()
                      .fade(duration: 600.ms)
                      .scale(begin: Offset(0.6, 0.6)),
                ),

                Gap(3.h),

                // ── White card ─────────────────────────────────────────────────
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Vérification OTP",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(1.h),

                            RichText(
                              text: TextSpan(
                                text: "Un code a été envoyé au ",
                                style: TextStyle(
                                  color: appColorBlack.withValues(alpha: 0.5),
                                  fontSize: 13.sp,
                                  height: 1.6,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.phone ?? "votre numéro",
                                    style: TextStyle(
                                      color: appColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(4.h),

                            // ── PIN input centered ──────────────────────────
                            Center(
                              child: Pinput(
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                controller: pinController,
                                pinputAutovalidateMode:
                                PinputAutovalidateMode.disabled,
                                hapticFeedbackType:
                                HapticFeedbackType.lightImpact,
                                showCursor: true,
                                onCompleted: (pin) => otp = pin,
                                onChanged: (value) {},
                              ).animate().fadeIn(duration: 800.ms),
                            ),

                            Gap(4.h),

                            // ── Timer + resend ──────────────────────────────
                            Center(
                              child: Column(
                                children: [
                                  if (!_canResend) ...[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: appColorBlack.withValues(alpha: 0.5),
                                          size: 4.5.w,
                                        ),
                                        Gap(1.w),
                                        Text(
                                          "Code valable pendant  ",
                                          style: TextStyle(
                                            color:
                                            appColorBlack.withValues(alpha: 0.5),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration: 400.ms,
                                          child: Text(
                                            _timerLabel,
                                            key: ValueKey(_remainingSeconds),
                                            style: TextStyle(
                                              color: appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  Gap(1.h),
                                  GestureDetector(
                                    onTap: _canResend ? _startTimer : null,
                                    child: AnimatedOpacity(
                                      duration: 300.ms,
                                      opacity: _canResend ? 1.0 : 0.4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 1.2.h),
                                        decoration: BoxDecoration(
                                          color: _canResend
                                              ? appColor.withValues(alpha: 0.1)
                                              : Colors.grey.shade100,
                                          borderRadius:
                                          BorderRadius.circular(3.w),
                                          border: Border.all(
                                            color: _canResend
                                                ? appColor.withValues(alpha: 0.3)
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.refresh_rounded,
                                              color: _canResend
                                                  ? appColor
                                                  : Colors.grey,
                                              size: 4.5.w,
                                            ),
                                            Gap(2.w),
                                            Text(
                                              "Renvoyer le code",
                                              style: TextStyle(
                                                color: _canResend
                                                    ? appColor
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 900.ms),

                            Gap(5.h),

                            // ── Submit button ───────────────────────────────
                            SubmitButton(
                              AppConstants.btnProceed,
                              onPressed: () async {
                                if (pinController.text.length < 6) {
                                  SnackbarHelper.showError(
                                    context,
                                    "Veuillez saisir le code OTP complet",
                                  );
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewPasswordPage(),
                                  ),
                                );
                              },
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(3.h),

                            // Back to login
                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Mauvais numéro ? ",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Modifier",
                                        style: TextStyle(
                                          color: appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(duration: 1100.ms),

                            Gap(4.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}