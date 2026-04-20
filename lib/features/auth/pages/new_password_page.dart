import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/themes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import '../../menu/menu.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final password = TextEditingController();
  final newPassword = TextEditingController();

  // ── Password strength ──────────────────────────────────────────────────────
  double _strength = 0;
  String _strengthLabel = "";
  Color _strengthColor = Colors.transparent;

  void _evaluateStrength(String value) {
    double s = 0;
    if (value.length >= 8) s += 0.25;
    if (value.contains(RegExp(r'[A-Z]'))) s += 0.25;
    if (value.contains(RegExp(r'[0-9]'))) s += 0.25;
    if (value.contains(RegExp(r'[!@#\$&*~%^]'))) s += 0.25;

    String label;
    Color color;
    if (s <= 0.25) {
      label = "Faible";
      color = Colors.red;
    } else if (s <= 0.5) {
      label = "Moyen";
      color = Colors.orange;
    } else if (s <= 0.75) {
      label = "Bien";
      color = Colors.amber;
    } else {
      label = "Fort";
      color = Colors.green;
    }

    setState(() {
      _strength = s;
      _strengthLabel = label;
      _strengthColor = color;
    });
  }

  @override
  void dispose() {
    password.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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

                // ── Icon ───────────────────────────────────────────────────────
                Center(
                  child:
                      Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lock_open_rounded,
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
                          horizontal: 6.w,
                          vertical: 4.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Nouveau mot de passe",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(1.h),

                            Text(
                              "Choisissez un mot de passe fort et différent du précédent.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 13.sp,
                                height: 1.6,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(3.h),

                            // ── Password field ──────────────────────────────
                            _FieldLabel("Nouveau mot de passe"),
                            Gap(0.8.h),
                            InputPassword(
                              hintText: "••••••••",
                              controller: password,
                              validatorMessage:
                                  "Veuillez saisir votre mot de passe",
                              onChanged: _evaluateStrength,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: appColor,
                                  size: 5.w,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ).animate().fadeIn(duration: 800.ms),

                            // ── Strength indicator ──────────────────────────
                            if (_strength > 0) ...[
                              Gap(1.2.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: _strength,
                                        minHeight: 5,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation(
                                          _strengthColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(3.w),
                                  Text(
                                    _strengthLabel,
                                    style: TextStyle(
                                      color: _strengthColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(duration: 300.ms),
                            ],

                            Gap(2.5.h),

                            // ── Confirm password field ──────────────────────
                            _FieldLabel("Confirmer le mot de passe"),
                            Gap(0.8.h),
                            InputPassword(
                              hintText: "••••••••",
                              controller: newPassword,
                              validatorMessage:
                                  "Veuillez confirmer votre mot de passe",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez confirmer votre mot de passe";
                                }
                                if (value != password.text) {
                                  return "Les mots de passe ne correspondent pas";
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: appColor,
                                  size: 5.w,
                                ),
                                onPressed: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                              ),
                            ).animate().fadeIn(duration: 900.ms),

                            Gap(3.h),

                            // ── Tips box ────────────────────────────────────
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: appColor.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: appColor.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shield_outlined,
                                        color: appColor,
                                        size: 4.5.w,
                                      ),
                                      Gap(2.w),
                                      Text(
                                        "Conseils de sécurité",
                                        style: TextStyle(
                                          color: appColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(1.h),
                                  ...[
                                    "Au moins 8 caractères",
                                    "Une lettre majuscule",
                                    "Un chiffre",
                                    "Un caractère spécial (!@#\$...)",
                                  ].map(
                                    (tip) => Padding(
                                      padding: EdgeInsets.only(bottom: 0.4.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 1.5.w,
                                            color: appColor.withValues(
                                              alpha: 0.6,
                                            ),
                                          ),
                                          Gap(2.w),
                                          Text(
                                            tip,
                                            style: TextStyle(
                                              color: appColorBlack.withValues(
                                                alpha: 0.55,
                                              ),
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(4.h),

                            // ── Submit button ───────────────────────────────
                            SubmitButton(
                              AppConstants.btnContinue,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuPage(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  SnackbarHelper.showError(
                                    context,
                                    "Tous les champs sont obligatoires",
                                  );
                                }
                              },
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

// ── Reusable field label ──────────────────────────────────────────────────────
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
