import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';
import 'package:terra_agent/features/missions/pages/pages.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<Map<String, dynamic>> aventures = [
    {
      "nom": "Daymond",
      "mission": "Recensement",
      "lieu": "Abidjan, Cocody",
      "pays": "assets/images/flag_ci.png",
      "montant": "1 500 CFA",
      "cumul": "100",
      "nombre": "45",
      "image": "assets/images/one.png",
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
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3.w),
                  bottomRight: Radius.circular(3.w),
                ),
                gradient: LinearGradient(
                  colors: [appColor, appColorSecondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Solde",
                        style: TextStyle(
                          color: appWhite,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "38.000 CFA",
                        style: TextStyle(
                          color: appWhite,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        color: appColorBlack,
                        padding: EdgeInsets.all(1.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: appWhite,
                              size: 18.sp,
                            ),
                            Text(
                              "17.800 CFA",
                              style: TextStyle(
                                color: appWhite,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: CancelButton(
                      height: 4.h,
                      AppConstants.btnCashOut,
                      textcouleur: appColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Gap(2.h),
            Container(
              margin: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.w),
                  color: appColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: appColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: "Missions en cours"),
                  Tab(text: "Missions terminees"),
                ],
              ),
            ),
            Gap(1.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: aventures.length,
                    itemBuilder: (context, index) {
                      final aventure = aventures[index];
                      return _buildAventureList(context, aventure);
                    },
                  ),
                  _buildAventureCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAventureList(BuildContext context, Map<String, dynamic> data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateMissionPage(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(3.w),
      child: Container(
        padding: EdgeInsets.all(3.w),
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    data["image"],
                    width: 8.w,
                    height: 8.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["nom"].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data["mission"],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 11.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            data["pays"],
                            width: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Flexible(
                            child: Text(
                              data["lieu"],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
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
                Column(
                  children: [
                    Container(
                      color: appColorSecondary.withValues(alpha: .3),
                      padding: EdgeInsets.all(1.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: appColorBlack,
                            size: 18.sp,
                          ),
                          Text(
                            data["montant"],
                            style: TextStyle(
                              color: appColorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.how_to_reg,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        Gap(1.w),
                        Text(
                          "${data["nombre"]}/",
                          style: TextStyle(
                            color: appColorSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          data["cumul"],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAventureCard() {
    return Container();
  }
}
