import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/features/home/pages/pages.dart';
import 'package:terra_agent/features/menu/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = "Tous";
  final List<String> _filters = ["Tous", "Terrain", "Bureau", "Urgent"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header gradient card ─────────────────────────────────────────
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
                  // Greeting row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bonjour 👋",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            "Jean Konan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
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
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                            size: 6.w,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms),

                  Gap(2.h),

                  // Balance + Cashout row
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(0.6.h),
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
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
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
                              horizontal: 4.w,
                              vertical: 1.2.h,
                            ),
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
                                  size: 4.5.w,
                                ),
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

            // ── Section title + filter ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Liste des offres",
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "10 missions disponibles",
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
                        color: appColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(2.w),
                        border: Border.all(
                          color: appColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.filter_list_rounded,
                            color: appColor,
                            size: 4.5.w,
                          ),
                          Gap(1.w),
                          Text(
                            "Filtrer",
                            style: TextStyle(
                              color: appColor,
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

            // ── Filter chips ──────────────────────────────────────────────────
            SizedBox(
              height: 4.5.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => Gap(2.w),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? appColor : Colors.white,
                        borderRadius: BorderRadius.circular(10.w),
                        border: Border.all(
                          color: isSelected ? appColor : Colors.grey.shade300,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: appColor.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : appColorBlack,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(duration: 700.ms),

            Gap(1.5.h),

            // ── Grid of offers ────────────────────────────────────────────────
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.w,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  return _OfferCard(
                        index: index,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailHomePage(),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(
                        duration: 400.ms,
                        delay: Duration(milliseconds: 60 * index),
                      )
                      .slideY(
                        begin: 0.1,
                        duration: 350.ms,
                        delay: Duration(milliseconds: 60 * index),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Offer card widget ─────────────────────────────────────────────────────────
class _OfferCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const _OfferCard({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.w),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company logo + info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.5.w),
                    border: Border.all(
                      color: appColorSecondary.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/one.png",
                    width: 7.w,
                    height: 7.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DAYMOND",
                        style: TextStyle(
                          color: appColorBlack,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Recensement",
                        style: TextStyle(
                          color: appColorBlack.withValues(alpha: 0.55),
                          fontSize: 11.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Gap(1.5.h),

            // Location
            _InfoRow(
              icon: Icons.location_on_rounded,
              color: appColor,
              text: "Abidjan, Cocody",
            ),
            Gap(0.6.h),

            // Mission type
            _InfoRow(
              icon: Icons.directions_walk_rounded,
              color: Colors.orange.shade600,
              text: "Sur Terrain",
            ),
            Gap(0.6.h),

            // Amount
            _InfoRow(
              icon: Icons.payments_rounded,
              color: Colors.green.shade600,
              text: "1 500 CFA",
              bold: true,
            ),
            Gap(0.6.h),

            // Deadline
            _InfoRow(
              icon: Icons.event_rounded,
              color: Colors.grey.shade600,
              text: "12/12/25",
            ),

            const Spacer(),

            // Apply chip
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 0.8.h),
              decoration: BoxDecoration(
                color: appColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Center(
                child: Text(
                  "Voir l'offre",
                  style: TextStyle(
                    color: appColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable info row ─────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final bool bold;

  const _InfoRow({
    required this.icon,
    required this.color,
    required this.text,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 3.8.w),
        Gap(1.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: bold
                  ? appColorBlack
                  : appColorBlack.withValues(alpha: 0.65),
              fontSize: 11.sp,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
