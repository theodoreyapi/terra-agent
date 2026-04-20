import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

import '../../../core/utils/utils.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      "q": "Comment postuler à une mission ?",
      "a":
          "Rendez-vous sur l'onglet Accueil, parcourez les offres disponibles et appuyez sur \"Voir l'offre\" puis \"Postuler\" pour soumettre votre candidature.",
    },
    {
      "q": "Quand vais-je recevoir mon paiement ?",
      "a":
          "Les paiements sont traités sous 48h après validation de votre mission par l'entreprise. Le montant est crédité directement sur votre solde.",
    },
    {
      "q": "Comment retirer mon argent ?",
      "a":
          "Appuyez sur \"Retrait\" depuis la page d'accueil ou de missions. Entrez le montant et choisissez votre mode de paiement (Mobile Money, etc.).",
    },
    {
      "q": "Mon compte est bloqué, que faire ?",
      "a":
          "Contactez notre support via le formulaire ci-dessous ou envoyez un e-mail à support@terraagent.ci avec votre numéro de téléphone.",
    },
    {
      "q": "Comment mettre à jour mes documents ?",
      "a":
          "Allez dans Profil → Modifier le profil. Vous pouvez y mettre à jour votre photo de profil et vos informations personnelles.",
    },
  ];

  final message = TextEditingController();

  @override
  void dispose() {
    message.dispose();
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
            child: Column(
              children: [
                _TopBar(title: "Aide & Support"),
                Gap(2.h),

                // Icon
                Center(
                  child:
                      Container(
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.support_agent_rounded,
                              color: Colors.white,
                              size: 9.w,
                            ),
                          )
                          .animate()
                          .fade(duration: 500.ms)
                          .scale(begin: const Offset(0.7, 0.7)),
                ),

                Gap(2.h),

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
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 3.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contact chips
                          Row(
                            children: [
                              Expanded(
                                child: _ContactChip(
                                  icon: Icons.phone_rounded,
                                  label: "Appeler",
                                  sub: "+225 27 00 00 00",
                                  color: Colors.green.shade600,
                                  onTap: () {},
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: _ContactChip(
                                  icon: Icons.email_rounded,
                                  label: "E-mail",
                                  sub: "support@terra.ci",
                                  color: appColor,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ).animate().fadeIn(duration: 500.ms),

                          Gap(3.h),

                          // FAQ
                          Text(
                            "Questions fréquentes",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: 600.ms),
                          Gap(1.5.h),

                          ...List.generate(_faqs.length, (i) {
                            final isOpen = _expandedIndex == i;
                            return GestureDetector(
                              onTap: () => setState(
                                () => _expandedIndex = isOpen ? null : i,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: EdgeInsets.only(bottom: 1.5.h),
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: isOpen
                                      ? appColor.withValues(alpha: 0.04)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(3.w),
                                  border: Border.all(
                                    color: isOpen
                                        ? appColor.withValues(alpha: 0.3)
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _faqs[i]["q"]!,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isOpen
                                                  ? appColor
                                                  : appColorBlack,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          isOpen
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons
                                                    .keyboard_arrow_down_rounded,
                                          color: isOpen
                                              ? appColor
                                              : Colors.grey.shade400,
                                          size: 5.w,
                                        ),
                                      ],
                                    ),
                                    if (isOpen) ...[
                                      Gap(1.h),
                                      Text(
                                        _faqs[i]["a"]!,
                                        style: TextStyle(
                                          color: appColorBlack.withValues(
                                            alpha: 0.6,
                                          ),
                                          fontSize: 10.5.sp,
                                          height: 1.6,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }),

                          Gap(3.h),

                          // Contact form
                          Text(
                            "Envoyer un message",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(duration: 700.ms),
                          Gap(1.5.h),
                          TextFormField(
                            controller: message,
                            maxLines: 4,
                            style: TextStyle(fontSize: 11.sp),
                            decoration: InputDecoration(
                              hintText:
                                  "Décrivez votre problème ou question...",
                              hintStyle: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.4),
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
                                  color: appColor,
                                  width: 1.8,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(4.w),
                            ),
                          ).animate().fadeIn(duration: 700.ms),
                          Gap(2.h),
                          SubmitButton(
                            "Envoyer",
                            onPressed: () async {
                              if (message.text.trim().isNotEmpty) {
                                SnackbarHelper.showSuccess(
                                  context,
                                  "Message envoyé !",
                                );
                                message.clear();
                              } else {
                                SnackbarHelper.showError(
                                  context,
                                  "Veuillez écrire un message",
                                );
                              }
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

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final Color color;
  final VoidCallback onTap;

  const _ContactChip({
    required this.icon,
    required this.label,
    required this.sub,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.5.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 4.5.w),
            ),
            Gap(2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    sub,
                    style: TextStyle(
                      color: appColorBlack.withValues(alpha: 0.45),
                      fontSize: 12.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
