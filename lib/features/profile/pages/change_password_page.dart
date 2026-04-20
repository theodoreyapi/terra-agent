import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

import '../../../core/utils/utils.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final current = TextEditingController();
  final newPass = TextEditingController();
  final confirm = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  double _strength = 0;
  String _strengthLabel = "";
  Color _strengthColor = Colors.transparent;

  void _evaluateStrength(String value) {
    double s = 0;
    if (value.length >= 8) s += 0.25;
    if (value.contains(RegExp(r'[A-Z]'))) s += 0.25;
    if (value.contains(RegExp(r'[0-9]'))) s += 0.25;
    if (value.contains(RegExp(r'[!@#\$&*~%^]'))) s += 0.25;
    setState(() {
      _strength = s;
      _strengthLabel = s <= 0.25
          ? "Faible"
          : s <= 0.5
          ? "Moyen"
          : s <= 0.75
          ? "Bien"
          : "Fort";
      _strengthColor = s <= 0.25
          ? Colors.red
          : s <= 0.5
          ? Colors.orange
          : s <= 0.75
          ? Colors.amber
          : Colors.green;
    });
  }

  @override
  void dispose() {
    current.dispose();
    newPass.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          Container(
            height: 22.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColor, appColorSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _TopBar(title: "Changer le mot de passe"),
                  Gap(2.h),

                  // Icon
                  Center(
                    child:
                        Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.lock_reset_rounded,
                                color: Colors.white,
                                size: 9.w,
                              ),
                            )
                            .animate()
                            .fade(duration: 500.ms)
                            .scale(begin: const Offset(0.7, 0.7)),
                  ),

                  Gap(2.h),

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
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sécurité du compte",
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ).animate().fadeIn(duration: 500.ms),
                            Gap(0.5.h),
                            Text(
                              "Choisissez un mot de passe fort et unique.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.45),
                                fontSize: 13.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(3.h),

                            // Current password
                            _PasswordField(
                              hint: "Mot de passe actuel",
                              controller: current,
                              obscure: _obscureCurrent,
                              onToggle: () => setState(
                                () => _obscureCurrent = !_obscureCurrent,
                              ),
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? "Requis" : null,
                              delay: 100,
                            ),

                            Gap(2.h),

                            _FormSection(title: "Nouveau mot de passe"),
                            Gap(1.2.h),

                            _PasswordField(
                              hint: "Nouveau mot de passe",
                              controller: newPass,
                              obscure: _obscureNew,
                              onToggle: () =>
                                  setState(() => _obscureNew = !_obscureNew),
                              onChanged: _evaluateStrength,
                              validator: (v) {
                                if (v == null || v.isEmpty) return "Requis";
                                if (v.length < 6) {
                                  return "Minimum 6 caractères";
                                }
                                return null;
                              },
                              delay: 200,
                            ),

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
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(duration: 300.ms),
                            ],

                            Gap(1.5.h),

                            _PasswordField(
                              hint: "Confirmer le mot de passe",
                              controller: confirm,
                              obscure: _obscureConfirm,
                              onToggle: () => setState(
                                () => _obscureConfirm = !_obscureConfirm,
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return "Requis";
                                if (v != newPass.text) {
                                  return "Les mots de passe ne correspondent pas";
                                }
                                return null;
                              },
                              delay: 300,
                            ),

                            Gap(4.h),

                            SubmitButton(
                              "Enregistrer",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  SnackbarHelper.showSuccess(
                                    context,
                                    "Mot de passe mis à jour !",
                                  );
                                  Navigator.pop(context);
                                }
                              },
                            ).animate().fadeIn(duration: 500.ms),

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
}

class _TopBar extends StatelessWidget {
  final String title;

  const _TopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn(duration: 500.ms),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;

  const _FormSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 1.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Gap(2.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: appColorBlack,
          ),
        ),
      ],
    );
  }
}

// Password field with visibility toggle
class _PasswordField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int delay;

  const _PasswordField({
    required this.hint,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.validator,
    this.onChanged,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      style: TextStyle(fontSize: 11.sp),
      validator: validator,
      decoration: _fieldDecoration(
        hint: hint,
        icon: Icons.lock_outline_rounded,
        suffix: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: appColor,
            size: 5.w,
          ),
          onPressed: onToggle,
        ),
      ),
    ).animate().fadeIn(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: delay),
    );
  }
}

InputDecoration _fieldDecoration({
  required String hint,
  required IconData icon,
  Widget? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: appColorBlack.withValues(alpha: 0.4),
      fontSize: 11.sp,
    ),
    filled: true,
    fillColor: Colors.grey.shade100,
    prefixIcon: Icon(icon, color: appColor, size: 5.w),
    suffixIcon: suffix,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.w),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.w),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.w),
      borderSide: BorderSide(color: appColor, width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.w),
      borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
  );
}
