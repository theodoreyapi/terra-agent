import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:terra_agent/core/constants/constants.dart';
import 'package:terra_agent/core/themes/themes.dart';
import 'package:terra_agent/core/widgets/widgets.dart';

class MissionCreatePage extends StatefulWidget {
  const MissionCreatePage({super.key});

  @override
  State<MissionCreatePage> createState() => _MissionCreatePageState();
}

class _MissionCreatePageState extends State<MissionCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: appColorBlack),
        ),
        title: Text("Recensement", style: TextStyle(color: appColorBlack)),
        actions: [
          Container(
            padding: EdgeInsets.all(1.5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Image.asset(
              "assets/images/one.png",
              width: 8.w,
              height: 8.w,
              fit: BoxFit.cover,
            ),
          ),
          Gap(2.w),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.w),
        child: SubmitButton(
          fontSize: 16.sp,
          AppConstants.btnSave,
          couleur: appColorOrange,
          onPressed: () async {},
        ),
      ),
    );
  }
}
