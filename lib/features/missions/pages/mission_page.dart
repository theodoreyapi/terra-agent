import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/features/menu/menu.dart';
import 'package:terra_agent/features/missions/pages/pages.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<Map<String, dynamic>> _missions = [
    {
      "nom": "Daymond",
      "mission": "Recensement",
      "lieu": "Abidjan, Cocody",
      "pays": "assets/images/flag_ci.png",
      "montant": "1 500 CFA",
      "cumul": "100",
      "nombre": "45",
      "image": "assets/images/one.png",
      "statut": "En cours",
    },
    {
      "nom": "Emilie",
      "mission": "Collecte de données",
      "lieu": "Yamoussoukro",
      "pays": "assets/images/flag_ci.png",
      "montant": "2 000 CFA",
      "cumul": "100",
      "nombre": "45",
      "image": "assets/images/one.png",
      "statut": "En cours",
    },
  ];

  final List<Map<String, dynamic>> _completed = [
    {
      "nom": "Unilever CI",
      "mission": "Enquête marché",
      "lieu": "Bouaké",
      "pays": "assets/images/flag_ci.png",
      "montant": "3 000 CFA",
      "cumul": "80",
      "nombre": "80",
      "image": "assets/images/one.png",
      "statut": "Terminée",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header gradient
            Container(
              padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.5.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appColor, appColorSecondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
                boxShadow: [
                  BoxShadow(
                    color: appColor.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mes missions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${_missions.length} en cours · ${_completed.length} terminée(s)",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NotificationPage()),
                        ),
                        child: CircleAvatar(
                          radius: 5.w,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: Icon(Icons.notifications_active,
                              color: Colors.white, size: 6.w),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms),

                  Gap(2.h),

                  // Balance card
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.w),
                      border:
                      Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
                                  fontSize: 12.sp,
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
                                  Icon(Icons.lock_outline_rounded,
                                      color: Colors.white.withValues(alpha: 0.6),
                                      size: 3.5.w),
                                  Gap(1.w),
                                  Text(
                                    "17 800 CFA bloqués",
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.6),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(3.w),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.2.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: appColor,
                                    size: 4.5.w),
                                Gap(1.5.w),
                                Text(
                                  AppConstants.btnCashOut,
                                  style: TextStyle(
                                    color: appColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
                ],
              ),
            ),

            Gap(2.h),

            // Tab bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color: appColor,
                    boxShadow: [
                      BoxShadow(
                        color: appColor.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: appColorBlack.withValues(alpha: 0.5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13.sp),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13.sp),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_outline_rounded,
                              size: 16),
                          Gap(1.5.w),
                          Text("En cours"),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline_rounded,
                              size: 16),
                          Gap(1.5.w),
                          Text("Terminées"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms),

            Gap(1.5.h),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _missions.isEmpty
                      ? _EmptyState(
                    icon: Icons.assignment_outlined,
                    message: "Aucune mission en cours",
                  )
                      : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 0.5.h),
                    itemCount: _missions.length,
                    itemBuilder: (context, index) {
                      return _MissionCard(
                        data: _missions[index],
                        isCompleted: false,
                        delay: index * 80,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateMissionPage()),
                        ),
                      );
                    },
                  ),
                  _completed.isEmpty
                      ? const _EmptyState(
                    icon: Icons.check_circle_outline_rounded,
                    message: "Aucune mission terminée",
                  )
                      : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 0.5.h),
                    itemCount: _completed.length,
                    itemBuilder: (context, index) {
                      return _MissionCard(
                        data: _completed[index],
                        isCompleted: true,
                        delay: index * 80,
                        onTap: () {},
                      );
                    },
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

// Mission card
class _MissionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isCompleted;
  final int delay;
  final VoidCallback onTap;

  const _MissionCard({
    required this.data,
    required this.isCompleted,
    required this.onTap,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final int nombre = int.tryParse(data["nombre"].toString()) ?? 0;
    final int cumul = int.tryParse(data["cumul"].toString()) ?? 1;
    final double progress = (nombre / cumul).clamp(0.0, 1.0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.w),
      child: Container(
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: isCompleted
                ? Colors.green.shade200
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color: appColorSecondary.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Image.asset(data["image"],
                      width: 9.w, height: 9.w, fit: BoxFit.cover),
                ),
                Gap(3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["nom"].toString().toUpperCase(),
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text(
                        data["mission"],
                        style: TextStyle(
                          color: appColorBlack.withValues(alpha: 0.55),
                          fontSize: 12.sp,
                        ),
                      ),
                      Gap(0.4.h),
                      Row(
                        children: [
                          Image.asset(data["pays"], width: 3.5.w),
                          Gap(1.w),
                          Flexible(
                            child: Text(
                              data["lieu"],
                              style: TextStyle(
                                color: appColorBlack.withValues(alpha: 0.5),
                                fontSize: 11.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.shade50
                        : appColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Text(
                    data["statut"],
                    style: TextStyle(
                      color: isCompleted
                          ? Colors.green.shade600
                          : appColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            Gap(2.h),

            // Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.payments_rounded,
                            color: Colors.green.shade600, size: 4.w),
                        Gap(1.5.w),
                        Text(
                          data["montant"],
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(2.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: appColor.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.how_to_reg_rounded,
                            color: appColor, size: 4.w),
                        Gap(1.5.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data["nombre"],
                                style: TextStyle(
                                  color: appColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                              TextSpan(
                                text: " / ${data["cumul"]}",
                                style: TextStyle(
                                  color: appColorBlack.withValues(alpha: 0.4),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Gap(1.5.h),

            // Progress bar
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                        isCompleted ? Colors.green : appColor,
                      ),
                    ),
                  ),
                ),
                Gap(2.w),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: isCompleted ? Colors.green : appColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
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
  final IconData icon;
  final String message;

  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey.shade300, size: 18.w),
          Gap(2.h),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }
}