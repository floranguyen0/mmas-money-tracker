import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';


// final AuthService _auth = AuthService();

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  List<String> textList = [
    "Personal information",
    "Account link",
    "Change password",
    "sign out"
  ];
  List<IconData> iconList = [
    Icons.person,
    Icons.link_sharp,
    Icons.admin_panel_settings_sharp,
    Icons.logout
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(270.h),
          child: Container(
            height: 270,
            child: Padding(
              padding:  EdgeInsets.only(top: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Center(
                    child: CircleAvatar(
                      child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Color.fromRGBO(210, 234, 251, 1)),
                      radius: 35.r,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: Text(
                    "User name",
                    style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Colors.blueGrey, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.crop_free),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            "Free",
                            style: TextStyle(fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          )),
      body: Column(
        children: [
          // Divider(
          //   height: 0,
          //   thickness: 0.8,
          //   color: Colors.grey,
          // ),
          // Container(
          //   height: 13,
          //   color: Color.fromRGBO(210, 234, 251, 1),
          // ),
          Divider(
            height: 0,
            thickness: 0.8.w,
            color: grey,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: SizedBox(
              height: 60.h,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.sports_golf,
                      size: 30.sp,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Explore Premium',
                    style: TextStyle(fontSize: 25.sp),
                  )
                ],
              ),
            ),
          ),

          Divider(
            height: 0.h,
            thickness: 0.8.w,
            color: grey,
          ),

          Container(
            height: 60.h,
            color: Color.fromRGBO(237, 240, 243, 1),
          ),
          Divider(
            height: 1.h,
            thickness: 0.8.w,
            color: grey,
          ),

          Expanded(
            child: ListView.builder(
                itemCount: iconList.length,
                itemBuilder: (context, int) {
                  return SizedBox(
                    height: 60.h,
                    child: Column(children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                iconList[int],
                                size: 30.sp,
                              ),
                              onPressed: () async {
                                // await _auth.signOut();
                                // Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              textList[int],
                              style: TextStyle(fontSize: 25.sp),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 0.8.w,
                        color: grey,
                      ),
                    ]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
