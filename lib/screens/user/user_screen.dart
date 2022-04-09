import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/widgets/custom_appbar.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const UserScreen(),
    );
  }

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Profile'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/under_constraction.png',
            scale: 4,
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Text(
            'This page is under construction\nand will be available soon.',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(height: 1.5, fontSize: 16.sp),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
