import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../auth.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

class RegisterSchoolPage extends StatefulWidget {
  final String? nom;
  final String? prenom;
  final String? phone;
  final String? naissance;
  final String? password;
  final String? photo;
  final String? country;
  final String? state;
  final String? city;

  const RegisterSchoolPage({
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
  });

  @override
  State<RegisterSchoolPage> createState() => _RegisterSchoolPageState();
}

class _RegisterSchoolPageState extends State<RegisterSchoolPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedNiveau;
  String? _selectedDiplome;
  String? _selectedLangue;
  String? _selectedExperience;
  String? _selectedPermis;

  // Maps dropdown selections to icon
  static const _dropdownConfigs = [
    _DropdownConfig(
      key: 'niveau',
      label: "Niveau d'étude général",
      icon: Icons.school_rounded,
      items: ["Primaire", "Secondaire", "Université", "Autres"],
    ),
    _DropdownConfig(
      key: 'diplome',
      label: "Dernier diplôme obtenu",
      icon: Icons.workspace_premium_rounded,
      items: ["BEPC", "BAC", "Licence", "Master", "Doctorat"],
    ),
    _DropdownConfig(
      key: 'langue',
      label: "Langues parlées et écrites",
      icon: Icons.translate_rounded,
      items: ["Français", "Anglais", "Espagnol", "Autres"],
    ),
    _DropdownConfig(
      key: 'experience',
      label: "Expérience mission terrain",
      icon: Icons.work_history_rounded,
      items: ["Oui", "Non"],
    ),
    _DropdownConfig(
      key: 'permis',
      label: "Permis de conduire",
      icon: Icons.drive_eta_rounded,
      items: ["Oui", "Non"],
    ),
  ];

  String? _getValue(String key) {
    switch (key) {
      case 'niveau':
        return _selectedNiveau;
      case 'diplome':
        return _selectedDiplome;
      case 'langue':
        return _selectedLangue;
      case 'experience':
        return _selectedExperience;
      case 'permis':
        return _selectedPermis;
      default:
        return null;
    }
  }

  void _setValue(String key, String? val) {
    setState(() {
      switch (key) {
        case 'niveau':
          _selectedNiveau = val;
          break;
        case 'diplome':
          _selectedDiplome = val;
          break;
        case 'langue':
          _selectedLangue = val;
          break;
        case 'experience':
          _selectedExperience = val;
          break;
        case 'permis':
          _selectedPermis = val;
          break;
      }
    });
  }

  int get _filledCount => [
    _selectedNiveau,
    _selectedDiplome,
    _selectedLangue,
    _selectedExperience,
    _selectedPermis,
  ].where((v) => v != null).length;

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

                  // ── Step indicator ─────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Étape 3 sur 3",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "$_filledCount / 5 complétés",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms),
                        Gap(0.8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 3 / 3,
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
                            horizontal: 6.w, vertical: 4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Formation & Compétences",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                              ),
                            ).animate().fadeIn(duration: 600.ms),

                            Gap(0.8.h),

                            Text(
                              "Ces informations sont essentielles pour vous proposer des missions adaptées à votre profil.",
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 13.sp,
                                height: 1.6,
                              ),
                            ).animate().fadeIn(duration: 700.ms),

                            Gap(3.h),

                            // ── Dropdowns ──────────────────────────────────────
                            ...List.generate(
                              _dropdownConfigs.length,
                                  (i) {
                                final config = _dropdownConfigs[i];
                                final delay = Duration(milliseconds: 700 + i * 80);
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: _StyledDropdown(
                                    config: config,
                                    value: _getValue(config.key),
                                    onChanged: (val) =>
                                        _setValue(config.key, val),
                                  )
                                      .animate()
                                      .fadeIn(duration: 500.ms, delay: delay)
                                      .slideY(
                                      begin: 0.1,
                                      duration: 400.ms,
                                      delay: delay),
                                );
                              },
                            ),

                            Gap(2.h),

                            // ── Submit button ───────────────────────────────────
                            SubmitButton(
                              AppConstants.btnNext,
                              onPressed: () {
                                final allFilled = [
                                  _selectedNiveau,
                                  _selectedDiplome,
                                  _selectedLangue,
                                  _selectedExperience,
                                  _selectedPermis,
                                ].every((v) => v != null);

                                if (allFilled) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentPage(
                                        photo: widget.photo,
                                        nom: widget.nom,
                                        prenom: widget.prenom,
                                        phone: widget.phone,
                                        naissance: widget.naissance,
                                        password: widget.password,
                                        country: widget.country,
                                        state: widget.state,
                                        city: widget.city,
                                        niveau: _selectedNiveau,
                                        diplome: _selectedDiplome,
                                        langue: _selectedLangue,
                                        experience: _selectedExperience,
                                        permis: _selectedPermis,
                                      ),
                                    ),
                                  );
                                } else {
                                  SnackbarHelper.showError(
                                    context,
                                    "Veuillez remplir tous les champs",
                                  );
                                }
                              },
                            ).animate().fadeIn(duration: 1200.ms),

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

// ── Data class for dropdown config ────────────────────────────────────────────
class _DropdownConfig {
  final String key;
  final String label;
  final IconData icon;
  final List<String> items;

  const _DropdownConfig({
    required this.key,
    required this.label,
    required this.icon,
    required this.items,
  });
}

// ── Styled dropdown widget ────────────────────────────────────────────────────
class _StyledDropdown extends StatelessWidget {
  final _DropdownConfig config;
  final String? value;
  final void Function(String?) onChanged;

  const _StyledDropdown({
    required this.config,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value != null;

    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: config.label,
        labelStyle: TextStyle(
          color: appColorBlack,
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: isSelected
            ? appColor.withValues(alpha: 0.05)
            : appColorGrey,
        prefixIcon: Icon(
          config.icon,
          color: isSelected ? appColor : appColorBlack.withValues(alpha: 0.3),
          size: 5.5.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w),
          borderSide: BorderSide(
            color: isSelected ? appColor.withValues(alpha: 0.3) : Colors.transparent,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w),
          borderSide: BorderSide(color: appColor, width: 1.8),
        ),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
        suffixIcon: isSelected
            ? Icon(Icons.check_circle_rounded,
            color: appColor, size: 5.w)
            : null,
      ),
      icon: isSelected
          ? const SizedBox.shrink()
          : Icon(Icons.keyboard_arrow_down_rounded,
          color: appColorBlack.withValues(alpha: 0.4)),
      items: config.items.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val, style: TextStyle(fontSize: 14.sp)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (v) =>
      v == null ? "Veuillez sélectionner une option" : null,
    );
  }
}