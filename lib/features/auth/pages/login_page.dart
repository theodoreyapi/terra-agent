import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import '../../menu/menu.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

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

  var login = TextEditingController();
  var password = TextEditingController();

  String phoneIndicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(3.h),
              Text(
                AppConstants.appName,
                style: TextStyle(
                  color: appWhite,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3),
              Gap(5.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenue 👋",
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn(duration: 600.ms),
                        Gap(1.h),
                        Text(
                          "Veuillez renseigner vos informations pour vous reconnecter à votre espace.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                        Gap(4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                            countries: ['CI'],
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
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
                        ).animate().fadeIn(duration: 900.ms),
                        Gap(2.h),
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
                        ).animate().fadeIn(duration: 1000.ms),
                        Gap(1.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                color: appColorSecondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 1100.ms),
                        Gap(4.h),
                        SubmitButton(
                          AppConstants.btnLogin,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuPage(),
                                ),
                              );

                              ///loginUser(context);
                            } else {
                              SnackbarHelper.showError(
                                context,
                                "Tous les champs sont obligatoires",
                              );
                            }
                          },
                        ).animate().fadeIn(duration: 1200.ms),
                        Gap(3.h),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Pas encore de compte ? ${AppConstants.btnRegister}",
                              style: TextStyle(
                                color: appColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 1300.ms),
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

  Future<void> loginUser(BuildContext context) async {
    // Afficher une boîte de dialogue de chargement
    showDialog(
      context: context,
      barrierDismissible: false, // Empêcher de fermer en cliquant dehors
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              const Expanded(child: Text('Connexion encours...')),
            ],
          ),
        );
      },
    );

    try {
      // Autoriser les certificats auto-signés (attention en production)
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': phoneIndicator, 'password': password.text}),
      );

      final Map<String, dynamic> responseData = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (response.statusCode == 200) {
        await Future.wait([
          SharedPreferencesHelper().saveInteger(
            'id',
            responseData['data']['id'],
          ),
          SharedPreferencesHelper().saveString(
            'nom',
            responseData['data']['nom'],
          ),
          SharedPreferencesHelper().saveString(
            'prenom',
            responseData['data']['prenom'],
          ),
          SharedPreferencesHelper().saveString(
            'phone',
            responseData['data']['phone'],
          ),
          SharedPreferencesHelper().saveString(
            'naissance',
            responseData['data']['naissance'],
          ),
          SharedPreferencesHelper().saveString(
            'commune',
            responseData['data']['commune'],
          ),
          SharedPreferencesHelper().saveString(
            'photo',
            responseData['data']['photo'],
          ),
          SharedPreferencesHelper().saveString(
            'recto',
            responseData['data']['recto'],
          ),
          SharedPreferencesHelper().saveString(
            'verso',
            responseData['data']['verso'],
          ),
          SharedPreferencesHelper().saveString(
            'creation',
            responseData['data']['creation'],
          ),
        ]);

        SnackbarHelper.showSuccess(context, responseData['message']);
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
          (route) => false,
        );
      } else {
        Navigator.pop(context);
        SnackbarHelper.showError(context, responseData['message']);
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion $e");
    }
  }
}
