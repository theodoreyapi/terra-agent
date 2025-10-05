
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../auth.dart';

class RegisterSchoolPage extends StatefulWidget {
  String? nom;
  String? prenom;
  String? phone;
  String? naissance;
  String? password;
  String? photo;

  RegisterSchoolPage({
    super.key,
    this.nom,
    this.prenom,
    this.phone,
    this.naissance,
    this.password,
    this.photo,
  });

  @override
  State<RegisterSchoolPage> createState() => _RegisterSchoolPageState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RegisterSchoolPageState extends State<RegisterSchoolPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedNiveau;
  String? _selectedDiplome;
  String? _selectedLangue;
  String? _selectedExperience;
  String? _selectedPermis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: SafeArea(
        bottom: false,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(2.h),
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appWhite,
                    elevation: 0,
                    heroTag: 'BackSchool',
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
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2),
              Gap(2.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    height: MediaQuery.of(context).size.height,
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
                          "Ces information son très important pour vous "
                          "trouver des mission qui vous correspond",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ).animate().fadeIn(duration: 700.ms),
                        Gap(2.h),
                        // Niveau d'étude général
                        _buildDropdown(
                          label: "Niveau d'étude général",
                          value: _selectedNiveau,
                          items: [
                            "Primaire",
                            "Secondaire",
                            "Université",
                            "Autres",
                          ],
                          onChanged: (val) => setState(() => _selectedNiveau = val),
                        ),

                        // Dernier diplôme obtenu
                        _buildDropdown(
                          label: "Dernier diplôme obtenu",
                          value: _selectedDiplome,
                          items: [
                            "BEPC",
                            "BAC",
                            "Licence",
                            "Master",
                            "Doctorat",
                          ],
                          onChanged: (val) => setState(() => _selectedDiplome = val),
                        ),

                        // Langues parlées et écrites
                        _buildDropdown(
                          label: "Langues parlées et écrites",
                          value: _selectedLangue,
                          items: [
                            "Français",
                            "Anglais",
                            "Espagnol",
                            "Autres",
                          ],
                          onChanged: (val) => setState(() => _selectedLangue = val),
                        ),

                        // Expérience en mission terrain
                        _buildDropdown(
                          label: "Expérience mission terrain",
                          value: _selectedExperience,
                          items: ["Oui", "Non"],
                          onChanged: (val) => setState(() => _selectedExperience = val),
                        ),

                        // Permis de conduire
                        _buildDropdown(
                          label: "Permis de conduire",
                          value: _selectedPermis,
                          items: ["Oui", "Non"],
                          onChanged: (val) => setState(() => _selectedPermis = val),
                        ),
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnNext,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
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
                                  ),
                                ),
                              );
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ).animate().fadeIn(duration: 1150.ms),
                        Gap(1.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.w),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.w)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        value: value,
        items: items.map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
