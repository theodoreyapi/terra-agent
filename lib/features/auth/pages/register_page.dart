import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/features/auth/pages/register_country_page.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/widgets.dart';
import '../auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  late bool _isChecked = true;

  String? _selectedGender;

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

  var login = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var lastName = TextEditingController();
  var dateTime = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    dateTime.dispose();
    super.dispose();
  }

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // on empêche de sélectionner une date future
    );

    if (pickedDate != null) {
      final String formatted = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        dateTime.text = formatted;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(2.h),
              Text(
                AppConstants.appName,
                style: TextStyle(
                  color: appWhite,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3),
              Gap(2.h),
              Expanded(
                child: SingleChildScrollView(
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
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 25.w,
                                height: 25.w,
                                decoration: BoxDecoration(
                                  color: appColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  image: _image != null
                                      ? DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: _image == null
                                    ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: appColor.withValues(alpha: 0.3),
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: CircleAvatar(
                                  backgroundColor: appColor,
                                  radius: 18,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.image,
                                      size: 18,
                                      color: appWhite,
                                    ),
                                    onPressed: _pickImage,
                                  ),
                                ),
                              ),
                            ],
                          ).animate().fadeIn(duration: 800.ms),
                        ),
                        Gap(2.h),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Genre",
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedGender,
                          items: ["Homme", "Femme"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                        ),
                        Gap(1.h),
                        InputText(
                          hintText: "Nom",
                          keyboardType: TextInputType.text,
                          controller: name,
                          validatorMessage: "Veuillez saisir votre nom",
                        ).animate().fadeIn(duration: 900.ms),
                        Gap(1.h),
                        InputText(
                          hintText: "Prénoms",
                          keyboardType: TextInputType.text,
                          controller: lastName,
                          validatorMessage: "Veuillez saisir votre prénom",
                        ).animate().fadeIn(duration: 950.ms),
                        Gap(1.h),
                        InputText(
                          hintText: "E-mail",
                          keyboardType: TextInputType.emailAddress,
                          controller: lastName,
                          validatorMessage: "Veuillez saisir votre email",
                        ).animate().fadeIn(duration: 950.ms),
                        Gap(1.h),
                        InputText(
                          hintText: "Profession actuelle",
                          keyboardType: TextInputType.text,
                          controller: lastName,
                        ).animate().fadeIn(duration: 950.ms),
                        Gap(1.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: dateTime,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Date de naissance",
                              filled: true,
                              fillColor: appColorGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () => _selectDate(context),
                          ),
                        ).animate().fadeIn(duration: 1000.ms),
                        Gap(1.h),
                        Container(
                          padding: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                            color: appColorGrey,
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              color: _isFocused ? appColor : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: InternationalPhoneNumberInput(
                            focusNode: _focusNode,
                            onInputChanged: (PhoneNumber number) {
                              phoneIndicator = number.phoneNumber!;
                            },
                            onInputValidated: (bool value) {},
                            errorMessage: "Le numéro est invalide",
                            hintText: "Numéro de téléphone",
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            countries: ['CI'],
                            initialValue: number,
                            textFieldController: login,
                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            inputBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            onSaved: (PhoneNumber number) {},
                          ),
                        ).animate().fadeIn(duration: 1050.ms),
                        Gap(1.h),
                        InputPassword(
                          hintText: "Mot de passe",
                          controller: password,
                          validatorMessage:
                              "Veuillez saisir votre mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ).animate().fadeIn(duration: 1100.ms),
                        Gap(2.h),
                        SubmitButton(
                          AppConstants.btnNext,
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _image != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterCountryPage(
                                    photo: _image!.path,
                                    nom: name.text,
                                    prenom: lastName.text,
                                    phone: phoneIndicator,
                                    naissance: dateTime.text,
                                    password: password.text,
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
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: appColorBlack,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                          "En vous inscrivant, vous acceptez nos ",
                                    ),
                                    TextSpan(
                                      text: "Conditions d’utilisation",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: appColorSecondary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    const TextSpan(text: " et notre "),
                                    TextSpan(
                                      text: "Politique de confidentialité",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: appColorSecondary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    const TextSpan(text: "."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 1200.ms),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Déjà inscrit ? ${AppConstants.btnLogin}",
                              style: TextStyle(
                                color: appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 1250.ms),
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
