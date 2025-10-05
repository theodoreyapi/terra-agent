import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/utils/utils.dart';
import 'package:terra_agent/core/widgets/widgets.dart';
import 'package:terra_agent/features/auth/auth.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';

class DocumentPage extends StatefulWidget {
  String? nom;
  String? prenom;
  String? phone;
  String? naissance;
  String? password;
  String? photo;

  DocumentPage({
    super.key,
    this.nom,
    this.prenom,
    this.phone,
    this.naissance,
    this.password,
    this.photo,
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
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        switch (type) {
          case "cni":
            if (isRecto) {
              _rectoCNI = File(pickedFile.path);
            } else {
              _versoCNI = File(pickedFile.path);
            }
            break;
          case "permis":
            if (isRecto) {
              _rectoPermis = File(pickedFile.path);
            } else {
              _versoPermis = File(pickedFile.path);
            }
            break;
          case "diplome":
            if (isRecto) {
              _rectoDiplome = File(pickedFile.path);
            } else {
              _versoDiplome = File(pickedFile.path);
            }
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: SafeArea(
        bottom: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gap(2.h),

              /// Header
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appWhite,
                    elevation: 0,
                    heroTag: 'Back',
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: appColor,
                      size: 18,
                    ),
                  ),
                  Gap(2.w),
                  Text(
                    AppConstants.appName,
                    style: TextStyle(
                      color: appWhite,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),

              Gap(2.h),

              /// Content
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: appWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.w),
                      topRight: Radius.circular(6.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Inscription",
                        style: TextStyle(
                          color: appColorBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ).animate().fadeIn(duration: 600.ms),
                      Text(
                        "Ces informations sont très importantes pour vous "
                            "trouver des missions adaptées",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 13.sp,
                        ),
                      ).animate().fadeIn(duration: 700.ms),
                      Gap(2.h),

                      /// CNI
                      _buildCardUpload(
                        title: "Pièce d'identité ou passeport",
                        rectoFile: _rectoCNI,
                        versoFile: _versoCNI,
                        onPickRecto: () => _pickImage(isRecto: true, type: "cni"),
                        onPickVerso: () => _pickImage(isRecto: false, type: "cni"),
                      ),

                      /// Permis
                      _buildCardUpload(
                        title: "Permis de conduire",
                        rectoFile: _rectoPermis,
                        versoFile: _versoPermis,
                        onPickRecto: () =>
                            _pickImage(isRecto: true, type: "permis"),
                        onPickVerso: () =>
                            _pickImage(isRecto: false, type: "permis"),
                      ),

                      /// Diplôme
                      _buildCardUpload(
                        title: "Dernier diplôme (ex: BEPC)",
                        rectoFile: _rectoDiplome,
                        versoFile: _versoDiplome,
                        onPickRecto: () =>
                            _pickImage(isRecto: true, type: "diplome"),
                        onPickVerso: () =>
                            _pickImage(isRecto: false, type: "diplome"),
                      ),

                      Gap(2.h),

                      /// Bouton
                      SubmitButton(
                        AppConstants.btnRegister,
                        onPressed: () async {
                          if (_rectoCNI != null && _versoCNI != null) {

                          } else {
                            SnackbarHelper.showError(
                              context,
                              "Vos pièces d'identité sont obligatoires",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget upload (Recto / Verso)
  Widget _buildCardUpload({
    required String title,
    required File? rectoFile,
    required File? versoFile,
    required VoidCallback onPickRecto,
    required VoidCallback onPickVerso,
  }) {
    return Container(
      padding: EdgeInsets.all(2.w),
      margin: EdgeInsets.only(bottom: 2.w),
      decoration: BoxDecoration(
        color: appWhite,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ajouter une photo recto / verso de votre",
            style: TextStyle(fontSize: 13.sp, color: appColorBlack),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: appColorBlack,
            ),
          ),
          Gap(1.h),
          Row(
            children: [
              Expanded(
                child: _buildImageBox(file: rectoFile, onTap: onPickRecto),
              ),
              Gap(2.w),
              Expanded(
                child: _buildImageBox(file: versoFile, onTap: onPickVerso),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Petite box photo
  Widget _buildImageBox({
    required File? file,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: appColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(3.w),
          image: file != null
              ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: file == null
            ? Center(
          child: Icon(Icons.photo_camera,
              size: 25.sp, color: Colors.blueGrey),
        )
            : null,
      ).animate().fadeIn(duration: 800.ms),
    );
  }

}
