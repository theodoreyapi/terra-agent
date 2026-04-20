import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

class DetailHomePage extends StatefulWidget {
  const DetailHomePage({super.key});

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  final List<String> _tools = [
    "Polo",
    "Badge",
    "Note",
    "Forfait d'appel",
    "Casquette",
    "Sac de terrain",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // ── Gradient hero background ────────────────────────────────────────
          Container(
            height: 26.h,
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
                // ── Top bar ───────────────────────────────────────────────────
                Padding(
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
                        "Détail de l'offre",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(duration: 500.ms),
                    ],
                  ),
                ),

                // ── Company hero card ─────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Logo
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              color: appColorSecondary.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/one.png",
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DAYMOND",
                                style: TextStyle(
                                  color: appColorBlack,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Gap(0.3.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_rounded,
                                    color: Colors.red.shade400,
                                    size: 3.5.w,
                                  ),
                                  Gap(1.w),
                                  Text(
                                    "Limite : Jeudi 17 Janvier 2026",
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(0.5.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: appColor,
                                    size: 3.5.w,
                                  ),
                                  Gap(1.w),
                                  Text(
                                    "Abidjan, Yopougon",
                                    style: TextStyle(
                                      color: appColorBlack.withValues(
                                        alpha: 0.55,
                                      ),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(2.w),
                        // Apply button
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(3.w),
                              boxShadow: [
                                BoxShadow(
                                  color: appColor.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              AppConstants.btnJob,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
                ),

                Gap(2.h),

                // ── Scrollable content ────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About company
                        _SectionCard(
                          title: "L'entreprise",
                          icon: Icons.business_rounded,
                          delay: 100,
                          child: Text(
                            "Currently hosting your website elsewhere? Join the "
                            "3+ million website owners who enjoy fast, secure and "
                            "reliable web hosting here at Hostinger. Our expert team "
                            "will handle everything while your site stays up and running "
                            "throughout. That's right – no downtime. No data loss. No problem.",
                            style: TextStyle(
                              color: appColorBlack.withValues(alpha: 0.65),
                              fontSize: 13.sp,
                              height: 1.6,
                            ),
                          ),
                        ),

                        Gap(2.h),

                        // Mission description
                        _SectionCard(
                          title: "La mission",
                          icon: Icons.assignment_rounded,
                          delay: 150,
                          child: Text(
                            "Currently hosting your website elsewhere? Join the "
                            "3+ million website owners who enjoy fast, secure and "
                            "reliable web hosting here at Hostinger. Our expert team "
                            "will handle everything while your site stays up and running.",
                            style: TextStyle(
                              color: appColorBlack.withValues(alpha: 0.65),
                              fontSize: 13.sp,
                              height: 1.6,
                            ),
                          ),
                        ),

                        Gap(2.h),

                        // Mission details grid
                        _SectionCard(
                          title: "Détail de la mission",
                          icon: Icons.info_outline_rounded,
                          delay: 200,
                          child: Column(
                            children: [
                              _DetailGrid(
                                items: const [
                                  _DetailItem(
                                    label: "Type de mission",
                                    value: "Recensement",
                                  ),
                                  _DetailItem(
                                    label: "Cible",
                                    value: "Hommes et Femmes",
                                  ),
                                  _DetailItem(
                                    label: "Lieu",
                                    value: "🇨🇮 Abidjan, Yopougon",
                                  ),
                                  _DetailItem(
                                    label: "Objectif",
                                    value: "200 personnes / mois",
                                  ),
                                  _DetailItem(
                                    label: "Canal",
                                    value: "Terrain & en ligne",
                                  ),
                                  _DetailItem(
                                    label: "Gains",
                                    value: "1 500 CFA / personne",
                                    highlight: true,
                                  ),
                                  _DetailItem(
                                    label: "Formation",
                                    value: "Présentiel – Palmeraie",
                                  ),
                                  _DetailItem(label: "Durée", value: "3 mois"),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Gap(2.h),

                        // Profile required
                        _SectionCard(
                          title: "Profil recherché",
                          icon: Icons.person_search_rounded,
                          delay: 250,
                          child: _DetailGrid(
                            items: const [
                              _DetailItem(
                                label: "Genre",
                                value: "Homme & Femme",
                              ),
                              _DetailItem(label: "Âge", value: "14 – 35 ans"),
                              _DetailItem(
                                label: "Niveau minimum",
                                value: "Secondaire / BEPC",
                              ),
                              _DetailItem(
                                label: "Langues",
                                value: "Français, Anglais",
                              ),
                              _DetailItem(
                                label: "Résidence",
                                value: "🇨🇮 Yopougon, Adjamé, Cocody",
                              ),
                              _DetailItem(
                                label: "Agents recherchés",
                                value: "500 agents",
                                highlight: true,
                              ),
                            ],
                          ),
                        ),

                        Gap(2.h),

                        // Tools
                        _SectionCard(
                          title: "Outils de travail",
                          icon: Icons.build_rounded,
                          delay: 300,
                          child: Wrap(
                            spacing: 1.w,
                            runSpacing: 1.5.w,
                            children: _tools.map((label) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.5.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appColor.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(
                                    color: appColor.withValues(alpha: 0.25),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: appColor,
                                      size: 3.5.w,
                                    ),
                                    Gap(1.5.w),
                                    Text(
                                      label,
                                      style: TextStyle(
                                        color: appColor,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        Gap(2.h),

                        // Deadline banner
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(4.w),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Colors.red.shade400,
                                size: 6.w,
                              ),
                              Gap(3.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date limite de l'offre",
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Jeudi 17 Janvier 2026",
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fadeIn(
                          duration: 500.ms,
                          delay: Duration(milliseconds: 350),
                        ),

                        Gap(3.h),

                        // CTA button
                        SubmitButton(
                          AppConstants.btnJobSend,
                          onPressed: () async {},
                        ).animate().fadeIn(
                          duration: 500.ms,
                          delay: const Duration(milliseconds: 400),
                        ),

                        Gap(4.h),
                      ],
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

// ── Section card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final int delay;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: appColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Icon(icon, color: appColor, size: 5.w),
                  ),
                  Gap(2.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: appColorBlack,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gap(2.h),
              child,
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: delay),
        )
        .slideY(
          begin: 0.08,
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: delay),
        );
  }
}

// ── Detail grid (2 columns) ───────────────────────────────────────────────────
class _DetailGrid extends StatelessWidget {
  final List<_DetailItem> items;

  const _DetailGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: items[i]),
            Gap(2.w),
            Expanded(child: i + 1 < items.length ? items[i + 1] : SizedBox()),
          ],
        ),
      );
      if (i + 2 < items.length) rows.add(Gap(1.5.h));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }
}

// ── Detail item tile ──────────────────────────────────────────────────────────
class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _DetailItem({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: highlight
            ? appColor.withValues(alpha: 0.08)
            : appColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: highlight
              ? appColor.withValues(alpha: 0.25)
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: appColorBlack.withValues(alpha: 0.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(0.4.h),
          Text(
            value,
            style: TextStyle(
              color: highlight ? appColor : appColorBlack,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
