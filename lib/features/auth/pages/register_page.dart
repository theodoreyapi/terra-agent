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

typedef MenuEntry = DropdownMenuEntry<String>;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isChecked = false;
  String? _selectedGender;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  final login = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final profession = TextEditingController();
  final dateTime = TextEditingController();

  String phoneIndicator = "";
  PhoneNumber number = PhoneNumber(isoCode: 'CI');
  File? _image;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    login.dispose();
    password.dispose();
    name.dispose();
    lastName.dispose();
    email.dispose();
    profession.dispose();
    dateTime.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: appColor)),
        child: child!,
      ),
    );
    if (pickedDate != null) {
      setState(() {
        dateTime.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Top bar ──────────────────────────────────────────────────
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

                  Gap(1.h),

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
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title centered
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Créer un compte",
                                    style: TextStyle(
                                      color: appColorBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.sp,
                                    ),
                                  ).animate().fadeIn(duration: 600.ms),
                                  Gap(0.5.h),
                                  Text(
                                    "Ces informations nous aident à trouver\nles missions qui vous correspondent.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: appColorBlack.withValues(
                                        alpha: 0.5,
                                      ),
                                      fontSize: 13.sp,
                                      height: 1.6,
                                    ),
                                  ).animate().fadeIn(duration: 700.ms),
                                ],
                              ),
                            ),

                            Gap(2.5.h),

                            // ── Avatar picker ──────────────────────────────────
                            Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 26.w,
                                    height: 26.w,
                                    decoration: BoxDecoration(
                                      color: appColor.withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: appColor.withValues(alpha: 0.3),
                                        width: 2,
                                      ),
                                      image: _image != null
                                          ? DecorationImage(
                                              image: FileImage(_image!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.08,
                                          ),
                                          blurRadius: 12,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: _image == null
                                        ? Icon(
                                            Icons.person_rounded,
                                            size: 12.w,
                                            color: appColor.withValues(
                                              alpha: 0.4,
                                            ),
                                          )
                                        : null,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _pickImage,
                                      child: Container(
                                        width: 9.w,
                                        height: 9.w,
                                        decoration: BoxDecoration(
                                          color: appColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: appColor.withValues(
                                                alpha: 0.4,
                                              ),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_rounded,
                                          size: 4.5.w,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(duration: 800.ms),
                            ),

                            Gap(0.8.h),

                            Center(
                              child: Text(
                                "Photo de profil",
                                style: TextStyle(
                                  color: appColorBlack.withValues(alpha: 0.4),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),

                            Gap(3.h),

                            // ── Section: Identité ──────────────────────────────
                            _SectionTitle("Identité"),
                            Gap(1.2.h),

                            // Genre dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Genre",
                                labelStyle: TextStyle(
                                  color: appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor: appColorGrey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide(
                                    color: appColor,
                                    width: 1.8,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.8.h,
                                ),
                              ),
                              initialValue: _selectedGender,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: appColor,
                              ),
                              items: ["Homme", "Femme"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (v) =>
                                  setState(() => _selectedGender = v),
                              validator: (v) => v == null
                                  ? "Veuillez choisir votre genre"
                                  : null,
                            ).animate().fadeIn(duration: 850.ms),

                            Gap(1.2.h),

                            InputText(
                              hintText: "Nom",
                              keyboardType: TextInputType.text,
                              controller: name,
                              validatorMessage: "Veuillez saisir votre nom",
                            ).animate().fadeIn(duration: 900.ms),

                            Gap(1.2.h),

                            InputText(
                              hintText: "Prénoms",
                              keyboardType: TextInputType.text,
                              controller: lastName,
                              validatorMessage: "Veuillez saisir votre prénom",
                            ).animate().fadeIn(duration: 950.ms),

                            Gap(3.h),

                            // ── Section: Contact ───────────────────────────────
                            _SectionTitle("Contact & Profil"),
                            Gap(1.2.h),

                            InputText(
                              hintText: "Adresse e-mail",
                              keyboardType: TextInputType.emailAddress,
                              controller: email,
                              validatorMessage: "Veuillez saisir votre email",
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(1.2.h),

                            InputText(
                              hintText: "Profession actuelle",
                              keyboardType: TextInputType.text,
                              controller: profession,
                            ).animate().fadeIn(duration: 1000.ms),

                            Gap(1.2.h),

                            // Date picker field
                            TextFormField(
                              controller: dateTime,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                hintText: "Date de naissance",
                                hintStyle: TextStyle(
                                  color: appColorBlack,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                filled: true,
                                fillColor: appColorGrey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.w),
                                  borderSide: BorderSide(
                                    color: appColor,
                                    width: 1.8,
                                  ),
                                ),
                                suffixIcon: Icon(
                                  Icons.calendar_month_rounded,
                                  color: appColor,
                                  size: 5.w,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.8.h,
                                ),
                              ),
                            ).animate().fadeIn(duration: 1050.ms),

                            Gap(1.2.h),

                            // Phone input
                            AnimatedContainer(
                              duration: 250.ms,
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                color: appColorGrey,
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                  color: _isFocused
                                      ? appColor
                                      : Colors.transparent,
                                  width: 1.8,
                                ),
                              ),
                              child: InternationalPhoneNumberInput(
                                focusNode: _focusNode,
                                onInputChanged: (PhoneNumber number) {
                                  phoneIndicator = number.phoneNumber!;
                                },
                                onInputValidated: (bool value) {},
                                errorMessage: "Le numéro est invalide",
                                hintText: "07 00 00 00 00",
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                countries: ['CI'],
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                initialValue: number,
                                textFieldController: login,
                                formatInput: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                inputBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                onSaved: (PhoneNumber number) {},
                              ),
                            ).animate().fadeIn(duration: 1100.ms),

                            Gap(3.h),

                            // ── Section: Sécurité ──────────────────────────────
                            _SectionTitle("Sécurité"),
                            Gap(1.2.h),

                            InputPassword(
                              hintText: "Mot de passe",
                              controller: password,
                              validatorMessage:
                                  "Veuillez saisir votre mot de passe",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: appColor,
                                  size: 5.w,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ).animate().fadeIn(duration: 1150.ms),

                            Gap(3.h),

                            // ── Submit button ──────────────────────────────────
                            SubmitButton(
                              AppConstants.btnNext,
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _image != null &&
                                    _isChecked) {
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
                                } else if (_image == null) {
                                  SnackbarHelper.showError(
                                    context,
                                    "Veuillez ajouter une photo de profil",
                                  );
                                } else if (!_isChecked) {
                                  SnackbarHelper.showError(
                                    context,
                                    "Veuillez accepter les conditions d'utilisation",
                                  );
                                } else {
                                  SnackbarHelper.showError(
                                    context,
                                    "Tous les champs sont obligatoires",
                                  );
                                }
                              },
                            ).animate().fadeIn(duration: 1200.ms),

                            Gap(2.h),

                            // ── CGU checkbox ───────────────────────────────────
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 1.1,
                                  child: Checkbox(
                                    value: _isChecked,
                                    activeColor: appColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (value) =>
                                        setState(() => _isChecked = value!),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: appColorBlack.withValues(
                                          alpha: 0.6,
                                        ),
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "En vous inscrivant, vous acceptez nos ",
                                        ),
                                        TextSpan(
                                          text: "Conditions d'utilisation",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: appColor,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                        TextSpan(text: " et notre "),
                                        TextSpan(
                                          text: "Politique de confidentialité",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: appColor,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                        TextSpan(text: "."),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(duration: 1250.ms),

                            Gap(1.5.h),

                            // ── Login link ─────────────────────────────────────
                            Center(
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => LoginPage(),
                                      ),
                                    ),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Déjà inscrit ? ",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppConstants.btnLogin,
                                        style: TextStyle(
                                          color: appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(duration: 1300.ms),

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

// ── Section title widget ──────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

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
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: appColorBlack,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
