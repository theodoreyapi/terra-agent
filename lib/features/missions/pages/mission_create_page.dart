import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/utils/utils.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

class MissionCreatePage extends StatefulWidget {
  const MissionCreatePage({super.key});

  @override
  State<MissionCreatePage> createState() => _MissionCreatePageState();
}

class _MissionCreatePageState extends State<MissionCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final prenom = TextEditingController();
  final telephone = TextEditingController();
  final adresse = TextEditingController();
  final dateNaissance = TextEditingController();

  String? _selectedGenre;
  File? _photo;

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _photo = File(picked.path));
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: appColorOrange),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        dateNaissance.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    telephone.dispose();
    adresse.dispose();
    dateNaissance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Gradient top
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColorOrange, appColorYellow],
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 1.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nouveau recruit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "Recensement",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                        // Company logo
                        Container(
                          padding: EdgeInsets.all(1.5.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/one.png",
                            width: 9.w,
                            height: 9.w,
                            fit: BoxFit.cover,
                          ),
                        ).animate().fade(duration: 400.ms),
                      ],
                    ),
                  ),

                  Gap(1.h),

                  // White card content
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
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Photo picker
                            Center(
                              child: GestureDetector(
                                onTap: _pickPhoto,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 22.w,
                                      height: 22.w,
                                      decoration: BoxDecoration(
                                        color: appColorOrange.withOpacity(0.08),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: appColorOrange.withOpacity(0.3),
                                          width: 2,
                                        ),
                                        image: _photo != null
                                            ? DecorationImage(
                                          image: FileImage(_photo!),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                      ),
                                      child: _photo == null
                                          ? Icon(Icons.person_rounded,
                                          color: appColorOrange.withOpacity(0.4),
                                          size: 10.w)
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: BoxDecoration(
                                          color: appColorOrange,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: Icon(Icons.camera_alt_rounded,
                                            color: Colors.white, size: 4.w),
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn(duration: 600.ms),
                              ),
                            ),

                            Gap(0.8.h),
                            Center(
                              child: Text(
                                "Photo du recruit",
                                style: TextStyle(
                                  color: appColorBlack.withOpacity(0.4),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),

                            Gap(3.h),

                            // Section: Identité
                            _SectionTitle(
                                title: "Identité", color: appColorOrange),
                            Gap(1.2.h),

                            // Genre
                            DropdownButtonFormField<String>(
                              value: _selectedGenre,
                              decoration: InputDecoration(
                                labelText: "Genre",
                                labelStyle: TextStyle(
                                  color: appColorBlack.withOpacity(0.5),
                                  fontSize: 11.sp,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide(
                                      color: appColorOrange, width: 1.8),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.8.h),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: appColorOrange),
                              items: ["Homme", "Femme"].map((v) {
                                return DropdownMenuItem(
                                    value: v,
                                    child: Text(v,
                                        style: TextStyle(fontSize: 11.sp)));
                              }).toList(),
                              onChanged: (v) =>
                                  setState(() => _selectedGenre = v),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(1.5.h),

                            _StyledField(
                              hint: "Nom",
                              controller: nom,
                              validator: "Veuillez saisir le nom",
                              icon: Icons.badge_outlined,
                              accentColor: appColorOrange,
                            ).animate().fadeIn(duration: 750.ms),

                            Gap(1.5.h),

                            _StyledField(
                              hint: "Prénoms",
                              controller: prenom,
                              validator: "Veuillez saisir le prénom",
                              icon: Icons.person_outline_rounded,
                              accentColor: appColorOrange,
                            ).animate().fadeIn(duration: 800.ms),

                            Gap(1.5.h),

                            // Date naissance
                            TextFormField(
                              controller: dateNaissance,
                              readOnly: true,
                              onTap: _selectDate,
                              style: TextStyle(fontSize: 11.sp),
                              decoration: InputDecoration(
                                hintText: "Date de naissance",
                                hintStyle: TextStyle(
                                  color: appColorBlack.withOpacity(0.4),
                                  fontSize: 11.sp,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                prefixIcon: Icon(Icons.cake_outlined,
                                    color: appColorOrange, size: 5.w),
                                suffixIcon: Icon(Icons.calendar_month_rounded,
                                    color: appColorOrange, size: 5.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide(
                                      color: appColorOrange, width: 1.8),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.8.h),
                              ),
                            ).animate().fadeIn(duration: 850.ms),

                            Gap(3.h),

                            // Section: Contact
                            _SectionTitle(
                                title: "Contact", color: appColorOrange),
                            Gap(1.2.h),

                            _StyledField(
                              hint: "Numéro de téléphone",
                              controller: telephone,
                              validator: "Veuillez saisir le téléphone",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              accentColor: appColorOrange,
                            ).animate().fadeIn(duration: 900.ms),

                            Gap(1.5.h),

                            _StyledField(
                              hint: "Adresse / Lieu de résidence",
                              controller: adresse,
                              icon: Icons.location_on_outlined,
                              accentColor: appColorOrange,
                              maxLines: 2,
                            ).animate().fadeIn(duration: 950.ms),

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
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(5.w, 1.5.h, 5.w, 3.h),
        child: SubmitButton(
          AppConstants.btnSave,
          fontSize: 13.sp,
          couleur: appColorOrange,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              SnackbarHelper.showSuccess(context, "Recruit enregistré !");
              Navigator.pop(context);
            } else {
              SnackbarHelper.showError(
                  context, "Tous les champs sont obligatoires");
            }
          },
        ),
      ),
    );
  }
}

// Section title with accent bar
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 1.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: color,
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
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// Styled text field
class _StyledField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? validator;
  final IconData icon;
  final Color accentColor;
  final TextInputType keyboardType;
  final int maxLines;

  const _StyledField({
    required this.hint,
    required this.controller,
    this.validator,
    required this.icon,
    required this.accentColor,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(fontSize: 11.sp),
      validator: validator != null
          ? (v) => (v == null || v.isEmpty) ? validator : null
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: appColorBlack.withOpacity(0.4),
          fontSize: 11.sp,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(icon, color: accentColor, size: 5.w),
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
          borderSide: BorderSide(color: accentColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w),
          borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
        ),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
      ),
    );
  }
}