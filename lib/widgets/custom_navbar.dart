import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/screens/home/home_screen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(60),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name !=
                  HomeScreen.routeName) {
                if (Navigator.canPop(context)) {
                  Navigator.popUntil(
                      context, ModalRoute.withName(HomeScreen.routeName));
                } else {
                  Navigator.pushReplacementNamed(context, '/');
                }
              }
            },
            icon: const Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user');
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
