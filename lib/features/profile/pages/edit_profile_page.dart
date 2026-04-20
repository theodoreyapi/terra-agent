import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final nom = TextEditingController(text: "Yapi");
  final prenom = TextEditingController(text: "Théodore");
  final email = TextEditingController(text: "yapi.theodore@mail.com");
  final telephone = TextEditingController(text: "+225 07 00 00 00 00");
  final commune = TextEditingController(text: "Cocody, Abidjan");
  final dateNaissance = TextEditingController(text: "15/06/1998");

  File? _photo;

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _photo = File(picked.path));
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 6, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: appColor)),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(
        () => dateNaissance.text = DateFormat('dd/MM/yyyy').format(picked),
      );
    }
  }

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    email.dispose();
    telephone.dispose();
    commune.dispose();
    dateNaissance.dispose();
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
                  // Top bar
                  _TopBar(title: "Modifier le profil"),

                  Gap(1.5.h),

                  // Avatar
                  Center(
                    child: GestureDetector(
                      onTap: _pickPhoto,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 12,
                                ),
                              ],
                              image: _photo != null
                                  ? DecorationImage(
                                      image: FileImage(_photo!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/one.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 7.w,
                              height: 7.w,
                              decoration: BoxDecoration(
                                color: appColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 3.5.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 500.ms),
                  ),

                  Gap(2.h),

                  // White card form
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
                            _FormSection(title: "Identité"),
                            Gap(1.5.h),
                            _Field(
                              hint: "Nom",
                              controller: nom,
                              icon: Icons.badge_outlined,
                              validator: "Requis",
                            ),
                            Gap(1.5.h),
                            _Field(
                              hint: "Prénoms",
                              controller: prenom,
                              icon: Icons.person_outline_rounded,
                              validator: "Requis",
                            ),
                            Gap(1.5.h),
                            // Date
                            TextFormField(
                              controller: dateNaissance,
                              readOnly: true,
                              onTap: _selectDate,
                              style: TextStyle(fontSize: 11.sp),
                              decoration: _fieldDecoration(
                                hint: "Date de naissance",
                                icon: Icons.cake_outlined,
                                suffix: Icon(
                                  Icons.calendar_month_rounded,
                                  color: appColor,
                                  size: 5.w,
                                ),
                              ),
                            ).animate().fadeIn(
                              duration: 500.ms,
                              delay: const Duration(milliseconds: 200),
                            ),

                            Gap(3.h),
                            _FormSection(title: "Contact"),
                            Gap(1.5.h),
                            _Field(
                              hint: "Téléphone",
                              controller: telephone,
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                            Gap(1.5.h),
                            _Field(
                              hint: "Adresse e-mail",
                              controller: email,
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Gap(1.5.h),
                            _Field(
                              hint: "Commune / Résidence",
                              controller: commune,
                              icon: Icons.location_on_outlined,
                            ),

                            Gap(4.h),

                            SubmitButton(
                              AppConstants.btnSave,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  SnackbarHelper.showSuccess(
                                    context,
                                    "Profil mis à jour avec succès !",
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

// Generic text field
class _Field extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final String? validator;
  final TextInputType keyboardType;
  final int delay;

  const _Field({
    required this.hint,
    required this.controller,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 11.sp),
      validator: validator != null
          ? (v) => (v?.isEmpty ?? true) ? validator : null
          : null,
      decoration: _fieldDecoration(hint: hint, icon: icon),
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
