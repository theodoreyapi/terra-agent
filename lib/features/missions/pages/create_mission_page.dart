import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/features/missions/pages/pages.dart';

class CreateMissionPage extends StatefulWidget {
  const CreateMissionPage({super.key});

  @override
  State<CreateMissionPage> createState() => _CreateMissionPageState();
}

class _CreateMissionPageState extends State<CreateMissionPage> {
  final List<Map<String, dynamic>> _recruits = [
    {
      "nom": "Daymond",
      "prenom": "Daymond Daymond",
      "lieu": "Abidjan, Cocody",
      "montant": "1 500 CFA",
      "date": "01/09/2026",
      "statut": "Validé",
    },
    {
      "nom": "Emilie",
      "prenom": "Emilie Emilie",
      "lieu": "Yamoussoukro",
      "montant": "2 000 CFA",
      "date": "01/09/2025",
      "statut": "En attente",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Gradient hero background
          Container(
            height: 26.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColorOrange, appColorYellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
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
                      Expanded(
                        child: Text(
                          "DAYMOND",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                            size: 5.w,
                          ),
                        ),
                      ).animate().fade(duration: 400.ms),
                    ],
                  ),
                ),

                Gap(1.5.h),

                // Balance card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Solde disponible",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontSize: 13.sp,
                                ),
                              ),
                              Gap(0.4.h),
                              Text(
                                "38 000 CFA",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Gap(0.5.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.white.withValues(alpha: 0.6),
                                    size: 3.5.w,
                                  ),
                                  Gap(1.w),
                                  Text(
                                    "17 800 CFA bloqués",
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.6),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(3.w),
                        // Stats badge
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${_recruits.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "Recruits",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
                ),

                Gap(2.h),

                // White content area
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Section title + filter
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 3.h, 4.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Liste des recruits",
                                    style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${_recruits.length} personnes enregistrées",
                                    style: TextStyle(
                                      color: appColorBlack.withValues(alpha: 0.4),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: appColorOrange.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(2.w),
                                    border: Border.all(
                                      color: appColorOrange.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.filter_list_rounded,
                                        color: appColorOrange,
                                        size: 4.5.w,
                                      ),
                                      Gap(1.w),
                                      Text(
                                        "Filtrer",
                                        style: TextStyle(
                                          color: appColorOrange,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).animate().fadeIn(duration: 600.ms),
                        ),

                        Gap(1.5.h),

                        // List
                        Expanded(
                          child: _recruits.isEmpty
                              ? _EmptyState()
                              : ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 0.5.h,
                                  ),
                                  itemCount: _recruits.length,
                                  itemBuilder: (context, index) {
                                    return _RecruitCard(
                                      data: _recruits[index],
                                      delay: index * 80,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MissionCreatePage()),
        ),
        backgroundColor: appColorOrange,
        elevation: 4,
        child: const Icon(Icons.person_add_rounded, color: Colors.white),
      ),
    );
  }
}

// Recruit card
class _RecruitCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final int delay;

  const _RecruitCard({required this.data, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    final bool isValidated = data["statut"] == "Validé";

    return Container(
          padding: EdgeInsets.all(4.w),
          margin: EdgeInsets.only(bottom: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
            border: Border.all(
              color: isValidated
                  ? Colors.green.shade200
                  : Colors.orange.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar initials
              Container(
                width: 11.w,
                height: 11.w,
                decoration: BoxDecoration(
                  color: isValidated
                      ? Colors.green.shade50
                      : appColorOrange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isValidated
                        ? Colors.green.shade300
                        : appColorOrange.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    data["nom"].toString().substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: isValidated
                          ? Colors.green.shade700
                          : appColorOrange,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

              Gap(3.w),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data["nom"].toString().toUpperCase()} ${data["prenom"].toString().toUpperCase()}",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(0.4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: appColorOrange,
                          size: 3.5.w,
                        ),
                        Gap(1.w),
                        Flexible(
                          child: Text(
                            data["lieu"],
                            style: TextStyle(
                              color: appColorBlack.withValues(alpha: 0.5),
                              fontSize: 10.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(2.w),

              // Right side: amount + date + badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data["montant"],
                    style: TextStyle(
                      color: appColorBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap(0.4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.grey.shade400,
                        size: 3.w,
                      ),
                      Gap(1.w),
                      Text(
                        data["date"],
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  Gap(0.6.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 0.4.h,
                    ),
                    decoration: BoxDecoration(
                      color: isValidated
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Text(
                      data["statut"],
                      style: TextStyle(
                        color: isValidated
                            ? Colors.green.shade600
                            : Colors.orange.shade700,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
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

// Empty state
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_outlined, color: Colors.grey.shade300, size: 18.w),
          Gap(2.h),
          Text(
            "Aucun recruit enregistré",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(1.h),
          Text(
            "Appuyez sur + pour ajouter un recruit",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 10.sp),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }
}
