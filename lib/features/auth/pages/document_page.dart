import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/utils/utils.dart';
import 'package:terra_agent/core/widgets/widgets.dart';
import 'package:terra_agent/features/auth/auth.dart';

import '../../../core/constants/constants.dart';

class DocumentPage extends StatefulWidget {
  final String? nom;
  final String? prenom;
  final String? phone;
  final String? naissance;
  final String? password;
  final String? photo;
  final String? country;
  final String? state;
  final String? city;
  final String? niveau;
  final String? diplome;
  final String? langue;
  final String? experience;
  final String? permis;

  const DocumentPage({
    super.key,
    this.nom,
    this.prenom,
    this.phone,
    this.naissance,
    this.password,
    this.photo,
    this.country,
    this.state,
    this.city,
    this.niveau,
    this.diplome,
    this.langue,
    this.experience,
    this.permis,
  });

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();

  File? _rectoCNI, _versoCNI;
  File? _rectoPermis, _versoPermis;
  File? _rectoDiplome, _versoDiplome;

  Future<void> _pickImage({
    required bool isRecto,
    required String type,
    ImageSource source = ImageSource.camera,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        switch (type) {
          case "cni":
            isRecto
                ? _rectoCNI = File(pickedFile.path)
                : _versoCNI = File(pickedFile.path);
            break;
          case "permis":
            isRecto
                ? _rectoPermis = File(pickedFile.path)
                : _versoPermis = File(pickedFile.path);
            break;
          case "diplome":
            isRecto
                ? _rectoDiplome = File(pickedFile.path)
                : _versoDiplome = File(pickedFile.path);
            break;
        }
      });
    }
  }

  int get _uploadedCount => [
    _rectoCNI,
    _versoCNI,
    _rectoPermis,
    _versoPermis,
    _rectoDiplome,
    _versoDiplome,
  ].where((f) => f != null).length;

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
                  // ── Top bar ────────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
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

                  // ── Upload progress ────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Documents",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "$_uploadedCount / 6 photos ajoutées",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms),
                        Gap(0.8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _uploadedCount / 6,
                            minHeight: 5,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ).animate().fadeIn(duration: 600.ms),
                      ],
                    ),
                  ),

                  Gap(2.h),

                  // ── White card ─────────────────────────────────────────────
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
                              "Vos documents",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(0.8.h),

                            Text(
                              "Prenez des photos claires de vos documents recto et verso.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 13.sp,
                                height: 1.6,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(1.5.h),

                            // Info tip
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: Colors.amber.shade200,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.tips_and_updates_rounded,
                                    color: Colors.amber.shade700,
                                    size: 5.w,
                                  ),
                                  Gap(2.w),
                                  Expanded(
                                    child: Text(
                                      "Assurez-vous que les documents sont bien lisibles et non flous.",
                                      style: TextStyle(
                                        color: Colors.amber.shade800,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 750.ms),

                            Gap(3.h),

                            // ── CNI ─────────────────────────────────────────────
                            _DocumentCard(
                              title: "Pièce d'identité / Passeport",
                              icon: Icons.badge_rounded,
                              rectoFile: _rectoCNI,
                              versoFile: _versoCNI,
                              onPickRecto: () =>
                                  _pickImage(isRecto: true, type: "cni"),
                              onPickVerso: () =>
                                  _pickImage(isRecto: false, type: "cni"),
                              isRequired: true,
                            ).animate().fadeIn(
                              duration: 500.ms,
                              delay: Duration(milliseconds: 200),
                            ),

                            Gap(2.h),

                            // ── Permis ───────────────────────────────────────────
                            _DocumentCard(
                              title: "Permis de conduire",
                              icon: Icons.drive_eta_rounded,
                              rectoFile: _rectoPermis,
                              versoFile: _versoPermis,
                              onPickRecto: () =>
                                  _pickImage(isRecto: true, type: "permis"),
                              onPickVerso: () =>
                                  _pickImage(isRecto: false, type: "permis"),
                            ).animate().fadeIn(
                              duration: 500.ms,
                              delay: Duration(milliseconds: 350),
                            ),

                            Gap(2.h),

                            // ── Diplôme ──────────────────────────────────────────
                            _DocumentCard(
                              title: "Dernier diplôme (ex: BEPC)",
                              icon: Icons.workspace_premium_rounded,
                              rectoFile: _rectoDiplome,
                              versoFile: _versoDiplome,
                              onPickRecto: () =>
                                  _pickImage(isRecto: true, type: "diplome"),
                              onPickVerso: () =>
                                  _pickImage(isRecto: false, type: "diplome"),
                            ).animate().fadeIn(
                              duration: 500.ms,
                              delay: const Duration(milliseconds: 500),
                            ),

                            Gap(4.h),

                            // ── Submit button ────────────────────────────────────
                            SubmitButton(
                              AppConstants.btnRegister,
                              onPressed: () async {
                                if (_rectoCNI == null || _versoCNI == null) {
                                  SnackbarHelper.showError(
                                    context,
                                    "La pièce d'identité (recto & verso) est obligatoire",
                                  );
                                  return;
                                }
                                // TODO: appel API inscription
                              },
                            ).animate().fadeIn(duration: 800.ms),

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

// ── Document upload card ──────────────────────────────────────────────────────
class _DocumentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final File? rectoFile;
  final File? versoFile;
  final VoidCallback onPickRecto;
  final VoidCallback onPickVerso;
  final bool isRequired;

  const _DocumentCard({
    required this.title,
    required this.icon,
    required this.rectoFile,
    required this.versoFile,
    required this.onPickRecto,
    required this.onPickVerso,
    this.isRequired = false,
  });

  bool get _isComplete => rectoFile != null && versoFile != null;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: _isComplete ? appColor.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        border: Border.all(
          color: _isComplete
              ? appColor.withValues(alpha: 0.35)
              : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: _isComplete
                      ? appColor.withValues(alpha: 0.12)
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: _isComplete ? appColor : Colors.grey.shade400,
                  size: 5.5.w,
                ),
              ),
              Gap(3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: appColorBlack,
                            ),
                          ),
                        ),
                        if (isRequired)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Requis",
                              style: TextStyle(
                                color: Colors.red.shade400,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      _isComplete
                          ? "✓ Recto et verso ajoutés"
                          : "Ajoutez le recto et le verso",
                      style: TextStyle(
                        color: _isComplete
                            ? Colors.green.shade600
                            : appColorBlack.withValues(alpha: 0.4),
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(2.h),

          // Photo boxes
          Row(
            children: [
              Expanded(
                child: _PhotoBox(
                  label: "Recto",
                  file: rectoFile,
                  onTap: onPickRecto,
                ),
              ),
              Gap(3.w),
              Expanded(
                child: _PhotoBox(
                  label: "Verso",
                  file: versoFile,
                  onTap: onPickVerso,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Photo box ─────────────────────────────────────────────────────────────────
class _PhotoBox extends StatelessWidget {
  final String label;
  final File? file;
  final VoidCallback onTap;

  const _PhotoBox({
    required this.label,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = file != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 22.w,
        decoration: BoxDecoration(
          color: hasFile
              ? Colors.transparent
              : appColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color: hasFile
                ? appColor.withValues(alpha: 0.4)
                : Colors.grey.shade300,
            width: hasFile ? 1.5 : 1,
          ),
          image: hasFile
              ? DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
              : null,
        ),
        child: hasFile
            ? Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(1.5.w),
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.green,
                      size: 3.5.w,
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_rounded,
                    color: appColor.withValues(alpha: 0.5),
                    size: 6.w,
                  ),
                  Gap(0.5.h),
                  Text(
                    label,
                    style: TextStyle(
                      color: appColorBlack.withValues(alpha: 0.4),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ).animate().fadeIn(duration: 400.ms),
    );
  }
}
