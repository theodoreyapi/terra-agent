import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedFilter = "Toutes";
  final List<String> _filters = ["Toutes", "Missions", "Paiements", "Système"];

  final List<_NotifItem> _notifications = [
    _NotifItem(
      type: _NotifType.mission,
      title: "Nouvelle offre disponible",
      body:
          "Daymond recrute 50 agents pour une mission de recensement à Cocody.",
      time: "Il y a 5 min",
      isRead: false,
    ),
    _NotifItem(
      type: _NotifType.payment,
      title: "Paiement reçu",
      body: "Vous avez reçu 1 500 CFA pour la mission Recensement – Yopougon.",
      time: "Il y a 1h",
      isRead: false,
    ),
    _NotifItem(
      type: _NotifType.mission,
      title: "Mission validée",
      body:
          "Votre participation à la mission Collecte de données a été validée.",
      time: "Il y a 3h",
      isRead: true,
    ),
    _NotifItem(
      type: _NotifType.system,
      title: "Mise à jour disponible",
      body:
          "Une nouvelle version de l'application est disponible. Mettez à jour pour profiter des améliorations.",
      time: "Hier",
      isRead: true,
    ),
    _NotifItem(
      type: _NotifType.payment,
      title: "Retrait effectué",
      body:
          "Votre retrait de 5 000 CFA a été traité avec succès via Mobile Money.",
      time: "Hier",
      isRead: true,
    ),
    _NotifItem(
      type: _NotifType.mission,
      title: "Limite d'offre proche",
      body:
          "L'offre Emilie – Enquête marché expire dans 2 jours. Postulez vite !",
      time: "Il y a 2 jours",
      isRead: true,
    ),
    _NotifItem(
      type: _NotifType.system,
      title: "Profil incomplet",
      body:
          "Complétez votre profil pour accéder à plus de missions et augmenter vos chances.",
      time: "Il y a 3 jours",
      isRead: true,
    ),
  ];

  List<_NotifItem> get _filtered {
    if (_selectedFilter == "Toutes") return _notifications;
    final map = {
      "Missions": _NotifType.mission,
      "Paiements": _NotifType.payment,
      "Système": _NotifType.system,
    };
    return _notifications.where((n) => n.type == map[_selectedFilter]).toList();
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markRead(int index) {
    final filtered = _filtered;
    final original = _notifications.indexOf(filtered[index]);
    setState(() => _notifications[original].isRead = true);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Gradient top
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notifications",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            if (_unreadCount > 0)
                              Text(
                                "$_unreadCount non lue(s)",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 13.sp,
                                ),
                              ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 500.ms),
                      if (_unreadCount > 0)
                        GestureDetector(
                          onTap: _markAllRead,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(3.w),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              "Tout lire",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                    ],
                  ),
                ),

                Gap(1.5.h),

                // Filter chips
                SizedBox(
                  height: 4.5.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => Gap(2.w),
                    itemBuilder: (_, i) {
                      final f = _filters[i];
                      final isSelected = _selectedFilter == f;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = f),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 0.8.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10.w),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              f,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? appColor : Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ).animate().fadeIn(duration: 600.ms),

                Gap(2.h),

                // White content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w),
                      ),
                    ),
                    child: filtered.isEmpty
                        ? _EmptyState()
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (_, i) => _NotifCard(
                              item: filtered[i],
                              delay: i * 60,
                              onTap: () => _markRead(i),
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

// ── Notification types ────────────────────────────────────────────────────────
enum _NotifType { mission, payment, system }

// ── Notification data ─────────────────────────────────────────────────────────
class _NotifItem {
  final _NotifType type;
  final String title;
  final String body;
  final String time;
  bool isRead;

  _NotifItem({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });
}

// ── Notification card ─────────────────────────────────────────────────────────
class _NotifCard extends StatelessWidget {
  final _NotifItem item;
  final int delay;
  final VoidCallback onTap;

  const _NotifCard({required this.item, required this.onTap, this.delay = 0});

  IconData get _icon {
    switch (item.type) {
      case _NotifType.mission:
        return Icons.assignment_rounded;
      case _NotifType.payment:
        return Icons.payments_rounded;
      case _NotifType.system:
        return Icons.notifications_rounded;
    }
  }

  Color get _color {
    switch (item.type) {
      case _NotifType.mission:
        return appColor;
      case _NotifType.payment:
        return Colors.green.shade600;
      case _NotifType.system:
        return Colors.orange.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: 1.5.h),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: item.isRead
                  ? Colors.white
                  : _color.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(
                color: item.isRead
                    ? Colors.grey.shade100
                    : _color.withValues(alpha: 0.25),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: _color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_icon, color: _color, size: 5.5.w),
                ),

                Gap(3.w),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: appColorBlack,
                                fontSize: 12.sp,
                                fontWeight: item.isRead
                                    ? FontWeight.w600
                                    : FontWeight.w800,
                              ),
                            ),
                          ),
                          if (!item.isRead)
                            Container(
                              width: 2.w,
                              height: 2.w,
                              margin: EdgeInsets.only(left: 2.w, top: 1.w),
                              decoration: BoxDecoration(
                                color: _color,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      Gap(0.5.h),
                      Text(
                        item.body,
                        style: TextStyle(
                          color: appColorBlack.withValues(
                            alpha: item.isRead ? 0.45 : 0.65,
                          ),
                          fontSize: 11.sp,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(0.8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey.shade400,
                            size: 3.w,
                          ),
                          Gap(1.w),
                          Text(
                            item.time,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: Colors.grey.shade300,
            size: 18.w,
          ),
          Gap(2.h),
          Text(
            "Aucune notification",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(0.8.h),
          Text(
            "Vous serez notifié des nouvelles offres\net de vos paiements ici.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 10.sp,
              height: 1.6,
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }
}
