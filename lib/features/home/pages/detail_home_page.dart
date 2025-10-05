import 'package:flutter/material.dart';
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
  final List<String> items = [
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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(1.5.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.w),
                            border: Border.all(
                              color: appColorSecondary,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/one.png",
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(2.w),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daymond".toUpperCase(),
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Date limite de l'offre",
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Jeudi 17 Janvier 2026",
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 2,
                          child: CancelButton(
                            height: 4.h,
                            AppConstants.btnJob,
                            textcouleur: appColor,
                            onPressed: () {},
                          ),
                        ),
                        Gap(2.w),
                      ],
                    ),
                    Gap(2.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Informations sur l'entreprise",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(1.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Currently hosting your website elsewhere? Join the "
                              "3+ million website owners who enjoy fast, "
                              "secure and reliable web hosting here at Hostinger. "
                              "Our expert team will handle everything while "
                              "your site stays up and running throughout. "
                              "That’s right – no downtime. No data loss. "
                              "No problem.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "La mission",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(1.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Currently hosting your website elsewhere? Join the "
                              "3+ million website owners who enjoy fast, "
                              "secure and reliable web hosting here at Hostinger. "
                              "Our expert team will handle everything while "
                              "your site stays up and running throughout. "
                              "That’s right – no downtime. No data loss. "
                              "No problem.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Détail de la mission",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type de mission",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Recensement",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cible",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Les personnes physiques (Homme et Femme)",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lieu de la mission",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "🇨🇮Abidjan, Yopougon",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Objectif de recensement",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "200 personnes par mois",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Canal de recrutement",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Sur le terrain, en ligne",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gains",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "1500 / Personne",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Modalité de formation",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "En presentiel  Palmerais",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Durée de la mission",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "3 Mois",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profil recherché",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gens",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Homme et Femme",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Age",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "14-35 Ans",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Niveau d'études minimum",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Secondaire, BEPC",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Langues parlées",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "Français, Anglais",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(1.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lieu de residence",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "🇨🇮Abidjan, Yopougon, Adjame, cocody",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: appColor.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nombre d'agents recherches",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "500 Agents",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Container(
                      padding: EdgeInsets.all(3.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Outils de travail",
                            style: TextStyle(
                              color: appColorBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(1.h),
                          Wrap(
                            spacing: 2.w,
                            runSpacing: 2.w,
                            children: items.map((label) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                                decoration: BoxDecoration(
                                  color: appColor.withValues(alpha: .2),
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appColorBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      "Date limite de l'offre",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Jeudi 17 janvier 2026",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Gap(2.h),
                    SubmitButton(
                      AppConstants.btnJobSend,
                      onPressed: () async {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
