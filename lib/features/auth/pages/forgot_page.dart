import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../auth.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  var login = TextEditingController();
  String phoneIndicator = "";
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    login.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: [
          // ── Decorative circles ────────────────────────────────────
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
                // ── Top bar with back button ──────────────────────────
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

                // ── Icon illustration ────────────────────────────────
                Center(
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset_rounded,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  )
                      .animate()
                      .fade(duration: 600.ms)
                      .scale(begin: Offset(0.6, 0.6)),
                ),

                Gap(3.h),

                // ── White card ───────────────────────────────────────
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 4.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Mot de passe oublié",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(1.h),

                            Text(
                              "Entrez votre numéro de téléphone associé à votre compte. "
                                  "Vous recevrez un code OTP pour réinitialiser votre mot de passe.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                height: 1.6,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(4.h),

                            // ── Phone label ──────────────────────────
                            Text(
                              "Numéro de téléphone",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: appColorBlack.withValues(alpha: 0.7),
                              ),
                            ).animate().fadeIn(duration: 750.ms),

                            Gap(0.8.h),

                            // Phone input
                            AnimatedContainer(
                              duration: 250.ms,
                              padding:
                              EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                color: appColorGrey,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: _isFocused
                                      ? appColor
                                      : Colors.transparent,
                                  width: 1.8,
                                ),
                              ),
                              child: InternationalPhoneNumberInput(
                                focusNode: _focusNode,
                                onInputChanged: (PhoneNumber number) {
                                  phoneIndicator = number.phoneNumber!;
                                },
                                onInputValidated: (bool value) {},
                                errorMessage: "Le numéro est invalide",
                                hintText: "07 00 00 00 00",
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                  PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                const TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: login,
                                formatInput: true,
                                keyboardType:
                                const TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                                inputBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                onSaved: (PhoneNumber number) {},
                              ),
                            ).animate().fadeIn(duration: 800.ms),

                            Gap(1.5.h),

                            // Info tip
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: appColor.withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: appColor.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: appColor,
                                    size: 5.w,
                                  ),
                                  Gap(2.w),
                                  Expanded(
                                    child: Text(
                                      "Le code OTP sera valable pendant 1 minute.",
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 900.ms),

                            Gap(4.h),

                            // Submit button
                            SubmitButton(
                              AppConstants.btnPassword,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CodeOtpPage(),
                                    ),
                                  );
                                } else {
                                  SnackbarHelper.showError(
                                    context,
                                    "Tous les champs sont obligatoires",
                                  );
                                }
                              },
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(3.h),

                            // Back to login
                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Vous vous en souvenez ? ",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Se connecter",
                                        style: TextStyle(
                                          color: appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
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