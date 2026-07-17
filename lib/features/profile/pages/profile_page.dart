import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/features/auth/auth.dart';

import '../profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<_StatItem> _stats = const [
    _StatItem(
      label: "Missions Participées",
      value: "134",
      icon: Icons.assignment_outlined,
      color: Color(0xFF7C3AED),
      isAmount: false,
    ),
    _StatItem(
      label: "Missions Accomplies",
      value: "12",
      icon: Icons.check_circle_outline_rounded,
      color: Color(0xFF059669),
      isAmount: false,
    ),
    _StatItem(
      label: "Missions En cours",
      value: "3",
      icon: Icons.play_circle_outline_rounded,
      color: Color(0xFF0284C7),
      isAmount: false,
    ),
    _StatItem(
      label: "Montant Total Gagné",
      value: "1 530 000",
      icon: Icons.payments_rounded,
      color: Color(0xFFD97706),
      isAmount: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // ── Hero header ─────────────────────────────────────────────────
              Container(
                padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.5.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appColor, const Color(0xFF0057B8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.w),
                    bottomRight: Radius.circular(6.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appColor.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 24.w,
                              height: 24.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/one.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 7.w,
                                height: 7.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: appColor.withValues(alpha: 0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: appColor,
                                  size: 3.5.w,
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fade(duration: 600.ms)
                        .scale(begin: Offset(0.8, 0.8)),

                    Gap(1.5.h),

                    // Name
                    Text(
                      "Yapi Théodore",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.3,
                      ),
                    ).animate().fadeIn(duration: 600.ms),

                    Gap(0.5.h),

                    // Member since
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white.withValues(alpha: 0.65),
                          size: 3.5.w,
                        ),
                        Gap(1.5.w),
                        Text(
                          "Membre depuis le 12/12/2025",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 700.ms),

                    Gap(2.h),

                    // Quick info chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _InfoChip(
                          icon: Icons.location_on_rounded,
                          label: "Abidjan, CI",
                        ),
                        Gap(3.w),
                        _InfoChip(
                          icon: Icons.verified_rounded,
                          label: "Vérifié",
                        ),
                        Gap(3.w),
                        _InfoChip(icon: Icons.star_rounded, label: "4.8 / 5"),
                      ],
                    ).animate().fadeIn(duration: 800.ms),
                  ],
                ),
              ),

              Gap(3.h),

              // ── Stats grid ───────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiques",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 700.ms),
                    Gap(1.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _stats.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 3.w,
                        childAspectRatio: 1.05,
                      ),
                      itemBuilder: (context, index) {
                        return _StatCard(
                          item: _stats[index],
                          delay: 100 + index * 80,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Gap(3.h),

              // ── Profile info section ─────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informations personnelles",
                      style: TextStyle(
                        color: appColorBlack,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 800.ms),
                    Gap(1.5.h),
                    _ProfileInfoCard(
                      items: [
                        _ProfileInfoItem(
                          icon: Icons.phone_rounded,
                          label: "Téléphone",
                          value: "+225 07 00 00 00 00",
                        ),
                        _ProfileInfoItem(
                          icon: Icons.email_rounded,
                          label: "E-mail",
                          value: "yapi.theodore@mail.com",
                        ),
                        _ProfileInfoItem(
                          icon: Icons.cake_rounded,
                          label: "Date de naissance",
                          value: "15/06/1998",
                        ),
                        _ProfileInfoItem(
                          icon: Icons.location_on_rounded,
                          label: "Commune",
                          value: "Cocody, Abidjan",
                        ),
                      ],
                    ).animate().fadeIn(duration: 900.ms),
                  ],
                ),
              ),

              Gap(3.h),

              // ── Actions ──────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.edit_outlined,
                      label: "Modifier le profil",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfilePage()),
                      ),
                      delay: 200,
                    ),
                    _ActionTile(
                      icon: Icons.ballot_outlined,
                      label: "Documents",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MyDocumentsPage()),
                      ),
                      delay: 260,
                    ),
                    _ActionTile(
                      icon: Icons.lock_outline_rounded,
                      label: "Changer le mot de passe",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChangePasswordPage()),
                      ),
                      delay: 320,
                    ),
                    _ActionTile(
                      icon: Icons.help_outline_rounded,
                      label: "Aide & Support",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpSupportPage()),
                      ),
                      delay: 380,
                    ),
                    _ActionTile(
                      icon: Icons.logout_rounded,
                      label: "Se déconnecter",
                      onTap: () => showLogoutDialog(context),
                      color: Colors.red.shade400,
                      delay: 440,
                    ),
                  ],
                ),
              ),

              Gap(4.h),
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout_rounded,
              color: Colors.red.shade400,
              size: 5.w,
            ),
          ),
          Gap(3.w),
          Text(
            "Déconnexion",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        "Voulez-vous vraiment vous déconnecter de votre compte ?",
        style: TextStyle(
          color: appColorBlack.withValues(alpha: 0.6),
          fontSize: 15.sp,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(
            "Annuler",
            style: TextStyle(
              color: appColorBlack.withValues(alpha: 0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
            elevation: 0,
          ),
          onPressed: () {
            Navigator.of(ctx).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginPage()),
              (route) => false,
            );
          },
          child: const Text(
            "Se déconnecter",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

// ── Info chip in hero ─────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 3.5.w),
          Gap(1.5.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat item data ────────────────────────────────────────────────────────────
class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isAmount;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.isAmount,
  });
}

// ── Stat card ─────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final _StatItem item;
  final int delay;

  const _StatCard({required this.item, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Icon(item.icon, color: item.color, size: 5.5.w),
              ),

              Spacer(),

              // Value
              item.isAmount
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.value,
                          style: TextStyle(
                            color: item.color,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "CFA",
                          style: TextStyle(
                            color: item.color.withValues(alpha: 0.6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      item.value,
                      style: TextStyle(
                        color: item.color,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

              Gap(0.5.h),

              Text(
                item.label,
                style: TextStyle(
                  color: appColorBlack.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                  height: 1.4,
                ),
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
          begin: 0.1,
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: delay),
        );
  }
}

// ── Profile info card ─────────────────────────────────────────────────────────
class _ProfileInfoCard extends StatelessWidget {
  final List<_ProfileInfoItem> items;

  const _ProfileInfoCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: appColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Icon(item.icon, color: appColor, size: 4.5.w),
                    ),
                    Gap(3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            color: appColorBlack.withValues(alpha: 0.45),
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          item.value,
                          style: TextStyle(
                            color: appColorBlack,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1)
                Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
            ],
          );
        }),
      ),
    );
  }
}

class _ProfileInfoItem {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

// ── Action tile ───────────────────────────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final int delay;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? appColorBlack;
    return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(bottom: 1.5.h),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Icon(icon, color: c, size: 4.5.w),
                ),
                Gap(3.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: c,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: c.withValues(alpha: 0.4),
                  size: 5.w,
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: delay),
        )
        .slideX(
          begin: 0.05,
          duration: const Duration(milliseconds: 350),
          delay: Duration(milliseconds: delay),
        );
  }
}
