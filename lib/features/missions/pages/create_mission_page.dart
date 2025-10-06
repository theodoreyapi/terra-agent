import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> aventures = [
    {
      "nom": "Daymond",
      "prenom": "Daymond Daymond",
      "lieu": "Abidjan, Cocody",
      "montant": "1 500 CFA",
      "date": "01/09/2026",
    },
    {
      "nom": "Emilie",
      "prenom": "Emilie Emilie",
      "lieu": "Yamoussoukro",
      "montant": "2 000 CFA",
      "date": "01/09/2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorOrange,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: appWhite),
        ),
        title: Text("DAYMOND", style: TextStyle(color: appWhite)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: appWhite),
          ),
        ],
      ),
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
                  colors: [appColorOrange, appColorYellow],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
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
                        color: appColorYellow,
                        padding: EdgeInsets.all(1.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: appColorBlack,
                              size: 18.sp,
                            ),
                            Text(
                              "17.800 CFA",
                              style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 3.w),
              decoration: BoxDecoration(
                color: appColorOrange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Liste des recruts".toUpperCase(),
                    style: TextStyle(
                      color: appColorBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list_outlined),
                  ),
                ],
              ),
            ),
            Gap(2.h),
            Expanded(
              child: ListView.builder(
                itemCount: aventures.length,
                itemBuilder: (context, index) {
                  final aventure = aventures[index];
                  return _buildAventureList(context, aventure);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MissionCreatePage()),
          );
        },
        backgroundColor: appColorOrange,
        child: Icon(Icons.add, color: appWhite),
      ),
    );
  }

  Widget _buildAventureList(BuildContext context, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(3.w),
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data["nom"].toString().toUpperCase()} ${data["prenom"].toString().toUpperCase()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data["lieu"],
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.8),
                        fontSize: 13.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    data["montant"],
                    style: TextStyle(
                      color: appColorBlack,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data["date"],
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
