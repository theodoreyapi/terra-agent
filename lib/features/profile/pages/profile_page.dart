import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/themes/themes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.w),
                  bottomRight: Radius.circular(5.w),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 10.w,
                    backgroundColor: appWhite,
                    child: Image.asset(
                      "assets/images/one.png",
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(2.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yapi theodore",
                        style: TextStyle(
                          color: appWhite,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Date de creation",
                        style: TextStyle(
                          color: appWhite,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "12/12/25",
                        style: TextStyle(
                          color: appWhite,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: appColorMarron,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: appRedOpacity.withValues(alpha: .26),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Missions \nParticipees",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appWhite,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(4.h),
                        CircleAvatar(
                          backgroundColor: appWhite.withValues(alpha: .5),
                          radius: 25.sp,
                          child: Text(
                            "134",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Missions \nAccomplies",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appWhite,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(4.h),
                        CircleAvatar(
                          backgroundColor: appWhite.withValues(alpha: .5),
                          radius: 25.sp,
                          child: Text(
                            "12",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: Colors.blue.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Missions \nEn cours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appWhite,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(4.h),
                        CircleAvatar(
                          backgroundColor: appWhite.withValues(alpha: .5),
                          radius: 25.sp,
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade600,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: Colors.brown.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Montant Total \nGagne",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appWhite,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(4.h),
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: appWhite.withValues(alpha: .5),
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                          child: Text(
                            "1 530 000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
