import 'package:flutter/material.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/features/home/home.dart';
import 'package:terra_agent/features/missions/pages/pages.dart';
import 'package:terra_agent/features/profile/profile.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;

  final Widget _home = HomePage();
  final Widget _invite = MissionPage();
  final Widget _profile = ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: getBody(),
      ),

      /// Navigation bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: appColor,
        indicatorColor: appColor.withValues(alpha: 0.15),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          _buildNavItem(Icons.home_outlined, "Accueil", 0),
          _buildNavItem(Icons.radar_outlined, "Missions", 1),
          _buildNavItem(Icons.person_outline, "Profil", 2),
        ],
      ),
    );
  }
  
  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentPageIndex == index;
    return NavigationDestination(
      icon: Icon(
        icon,
        color: isSelected ? appColor : appColorBlack.withValues(alpha: 0.5),
        size: 24,
      ),
      label: label,
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _home;
    } else if (currentPageIndex == 1) {
      return _invite;
    } else {
      return _profile;
    }
  }
}
