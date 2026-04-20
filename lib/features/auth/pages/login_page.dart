import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../menu/menu.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  var login = TextEditingController();
  var password = TextEditingController();

  String phoneIndicator = "";
  String initialCountry = 'CI';
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
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: [
          // ── Decorative circles in background ──────────────────────
          Positioned(
            top: -6.w,
            right: -8.w,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            left: -12.w,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // ── Main content ───────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(4.h),

                  // Logo / App name
                  Column(
                    children: [
                      Container(
                            width: 16.w,
                            height: 16.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.work_rounded,
                              color: Colors.white,
                              size: 8.w,
                            ),
                          )
                          .animate()
                          .fade(duration: 500.ms)
                          .scale(begin: Offset(0.7, 0.7)),
                      Gap(1.5.h),
                      Text(
                        AppConstants.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
                      Gap(0.5.h),
                      Text(
                        "Votre plateforme emploi",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 14.sp,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(duration: 700.ms),
                    ],
                  ),

                  Gap(4.h),

                  // ── White card ─────────────────────────────────────
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
                          horizontal: 6.w,
                          vertical: 4.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Bienvenue 👋",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(0.8.h),

                            Text(
                              "Connectez-vous à votre espace personnel.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(4.h),

                            // ── Phone label ────────────────────────────
                            _FieldLabel("Numéro de téléphone"),
                            Gap(0.8.h),

                            // Phone input
                            AnimatedContainer(
                              duration: 250.ms,
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                                countries: ['CI'],
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                initialValue: number,
                                textFieldController: login,
                                formatInput: true,
                                keyboardType:
                                TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                inputBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                onSaved: (PhoneNumber number) {},
                              ),
                            ).animate().fadeIn(duration: 800.ms),

                            Gap(2.5.h),

                            // ── Password label ─────────────────────────
                            _FieldLabel("Mot de passe"),
                            Gap(0.8.h),

                            InputPassword(
                              hintText: "••••••••",
                              controller: password,
                              validatorMessage:
                                  "Veuillez saisir votre mot de passe",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: appColor,
                                  size: 5.w,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ).animate().fadeIn(duration: 900.ms),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ForgotPage(),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  "Mot de passe oublié ?",
                                  style: TextStyle(
                                    color: appColorSecondary,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(3.h),

                            // Login button
                            SubmitButton(
                              AppConstants.btnLogin,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuPage(),
                                    ),
                                  );
                                  // loginUser(context);
                                } else {
                                  SnackbarHelper.showError(
                                    context,
                                    "Tous les champs sont obligatoires",
                                  );
                                }
                              },
                            ).animate().fadeIn(duration: 1100.ms),

                            Gap(3.h),

                            // Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                  ),
                                  child: Text(
                                    "ou",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 1200.ms),

                            Gap(2.5.h),

                            // Register link
                            Center(
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => RegisterPage(),
                                      ),
                                    ),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Pas encore de compte ? ",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppConstants.btnRegister,
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
                            ).animate().fadeIn(duration: 1300.ms),

                            Gap(4.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        content: Row(
          children: [
            CircularProgressIndicator(color: appColor),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Connexion en cours...',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );

    try {
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': phoneIndicator, 'password': password.text}),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (!mounted) return;
      Navigator.pop(context); // close loader

      if (response.statusCode == 200) {
        await Future.wait([
          SharedPreferencesHelper().saveInteger(
            'id',
            responseData['data']['id'],
          ),
          SharedPreferencesHelper().saveString(
            'nom',
            responseData['data']['nom'],
          ),
          SharedPreferencesHelper().saveString(
            'prenom',
            responseData['data']['prenom'],
          ),
          SharedPreferencesHelper().saveString(
            'phone',
            responseData['data']['phone'],
          ),
          SharedPreferencesHelper().saveString(
            'naissance',
            responseData['data']['naissance'],
          ),
          SharedPreferencesHelper().saveString(
            'commune',
            responseData['data']['commune'],
          ),
          SharedPreferencesHelper().saveString(
            'photo',
            responseData['data']['photo'],
          ),
          SharedPreferencesHelper().saveString(
            'recto',
            responseData['data']['recto'],
          ),
          SharedPreferencesHelper().saveString(
            'verso',
            responseData['data']['verso'],
          ),
          SharedPreferencesHelper().saveString(
            'creation',
            responseData['data']['creation'],
          ),
        ]);

        SnackbarHelper.showSuccess(context, responseData['message']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
          (route) => false,
        );
      } else {
        SnackbarHelper.showError(context, responseData['message']);
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion : $e");
    }
  }
}

// ── Small reusable field label ────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: appColorBlack.withValues(alpha: 0.7),
      ),
    );
  }
}
