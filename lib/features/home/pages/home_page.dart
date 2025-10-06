import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';
import 'package:terra_agent/features/home/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 3.w),
              decoration: BoxDecoration(
                color: appColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Liste des offres".toUpperCase(),
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
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.w,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailHomePage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(3.w),
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: appWhite,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "Daymond".toUpperCase(),
                                      style: TextStyle(
                                        color: appColorBlack,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Recensement",
                                      style: TextStyle(
                                        color: appColorBlack.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/flag_ci.png",
                                          width: 4.w,
                                        ),
                                        Gap(1.w),
                                        Flexible(
                                          child: Text(
                                            "Abidjan, Cocody",
                                            style: TextStyle(
                                              color: appColorBlack.withValues(
                                                alpha: 0.8,
                                              ),
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
                            ],
                          ),

                          Gap(2.h),

                          // --- Statut ---
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: appColor,
                                size: 18.sp,
                              ),
                              Gap(1.w),
                              Text(
                                "Sur Terrain",
                                style: TextStyle(
                                  color: appColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          Gap(0.8.h),

                          // --- Montant ---
                          Row(
                            children: [
                              Icon(
                                Icons.how_to_reg_outlined,
                                color: appColorBlack,
                                size: 18.sp,
                              ),
                              Gap(1.w),
                              Text(
                                "1 500 CFA",
                                style: TextStyle(
                                  color: appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Gap(0.8.h),

                          // --- Délai ---
                          Row(
                            children: [
                              Icon(
                                Icons.history_outlined,
                                color: Colors.grey[800],
                                size: 18.sp,
                              ),
                              Gap(1.w),
                              Text(
                                "Délais: 12/12/25",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
