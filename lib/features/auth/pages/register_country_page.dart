import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/features/auth/pages/register_school_page.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../auth.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class RegisterCountryPage extends StatefulWidget {
  final String? nom;
  final String? prenom;
  final String? phone;
  final String? naissance;
  final String? password;
  final String? photo;

  const RegisterCountryPage({
    super.key,
    this.nom,
    this.prenom,
    this.phone,
    this.naissance,
    this.password,
    this.photo,
  });

  @override
  State<RegisterCountryPage> createState() => _RegisterCountryPageState();
}

class _RegisterCountryPageState extends State<RegisterCountryPage> {
  final _formKey = GlobalKey<FormState>();

  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: [
          // ── Decorative circles ────────────────────────────────────────────
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
            top: 10.h,
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top bar ──────────────────────────────────────────────────
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

                  Gap(1.5.h),

                  // ── Step indicator ───────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Étape 2 sur 3",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                        Gap(0.8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 2 / 3,
                            minHeight: 5,
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                          ),
                        ).animate().fadeIn(duration: 600.ms),
                      ],
                    ),
                  ),

                  Gap(2.h),

                  // ── White card ───────────────────────────────────────────────
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Votre localisation",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(0.8.h),

                            Text(
                              "Ces informations nous aident à trouver les missions disponibles près de chez vous.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 13.sp,
                                height: 1.6,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(3.h),

                            // ── Location icon banner ──────────────────────────
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: appColor.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: appColor.withValues(alpha: 0.15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.5.w),
                                    decoration: BoxDecoration(
                                      color: appColor.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: appColor,
                                      size: 6.w,
                                    ),
                                  ),
                                  Gap(3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sélectionnez votre zone",
                                          style: TextStyle(
                                            color: appColorBlack,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        Text(
                                          "Pays → Région → Ville",
                                          style: TextStyle(
                                            color:
                                            appColorBlack.withValues(alpha: 0.45),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 750.ms),

                            Gap(3.h),

                            // ── Country/State/City picker ─────────────────────
                            SelectState(
                              onCountryChanged: (value) =>
                                  setState(() => countryValue = value),
                              onStateChanged: (value) =>
                                  setState(() => stateValue = value),
                              onCityChanged: (value) =>
                                  setState(() => cityValue = value),
                            ).animate().fadeIn(duration: 800.ms),

                            Gap(3.h),

                            // ── Selected summary ──────────────────────────────
                            if (countryValue != null &&
                                countryValue!.isNotEmpty) ...[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(3.5.w),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(3.w),
                                  border: Border.all(
                                      color: Colors.green.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green.shade600,
                                      size: 5.w,
                                    ),
                                    Gap(2.w),
                                    Expanded(
                                      child: Text(
                                        [
                                          if (countryValue != null &&
                                              countryValue!.isNotEmpty)
                                            countryValue!,
                                          if (stateValue != null &&
                                              stateValue!.isNotEmpty)
                                            stateValue!,
                                          if (cityValue != null &&
                                              cityValue!.isNotEmpty)
                                            cityValue!,
                                        ].join(" › "),
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 300.ms),
                              Gap(3.h),
                            ],

                            // ── Submit button ─────────────────────────────────
                            SubmitButton(
                              AppConstants.btnNext,
                              onPressed: () {
                                if (countryValue == null ||
                                    countryValue!.isEmpty) {
                                  SnackbarHelper.showError(
                                    context,
                                    "Veuillez sélectionner votre pays",
                                  );
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterSchoolPage(
                                      photo: widget.photo,
                                      nom: widget.nom,
                                      prenom: widget.prenom,
                                      phone: widget.phone,
                                      naissance: widget.naissance,
                                      password: widget.password,
                                      country: countryValue,
                                      state: stateValue,
                                      city: cityValue,
                                    ),
                                  ),
                                );
                              },
                            ).animate().fadeIn(duration: 900.ms),

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