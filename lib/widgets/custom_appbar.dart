import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_market/screens/screens.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
          horizontal: ScreenUtil().setWidth(20),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
      ),
      actions: [
        ModalRoute.of(context)?.settings.name != WishListScreen.routeName
            ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                splashRadius: 20,
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
