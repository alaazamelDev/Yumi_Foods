import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/blocs/wishlist/wishlist_bloc.dart';
import 'package:yumi_food/widgets/widgets.dart';

class WishListScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WishListScreen(),
    );
  }

  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'WishList'),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is WishlistLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(5),
                vertical: ScreenUtil().setHeight(15),
              ),
              itemCount: state.wishlist.products.length,
              itemBuilder: (context, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ProductCard(
                    product: state.wishlist.products[index],
                    widthFactor: 1.1,
                    leftPostion: ScreenUtil().setWidth(120),
                    isWishlist: true,
                  ),
                ),
              ),
            );
          } else if (state is WishlistError) {
            Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
