
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

class RegisterCountryPage extends StatefulWidget {
  String? nom;
  String? prenom;
  String? phone;
  String? naissance;
  String? password;
  String? photo;

  RegisterCountryPage({
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

typedef MenuEntry = DropdownMenuEntry<String>;

class _RegisterCountryPageState extends State<RegisterCountryPage> {
  final _formKey = GlobalKey<FormState>();

  String? countryValue;
  String? stateValue;
  String? cityValue;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(2.h),
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appWhite,
                    elevation: 0,
                    heroTag: 'BackCity',
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
                        SelectState(
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              cityValue = value;
                            });
                          },
                        ),
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnNext,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Pays: $countryValue");
                              print("État/Région: $stateValue");
                              print("Ville: $cityValue");
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
}
