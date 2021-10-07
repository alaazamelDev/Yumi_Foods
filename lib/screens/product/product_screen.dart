import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_market/blocs/cart/cart_bloc.dart';
import 'package:online_market/blocs/wishlist/wishlist_bloc.dart';
import 'package:online_market/models/models.dart';
import 'package:online_market/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ProductScreen(
        product: product,
      ),
    );
  }

  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: ScreenUtil().setHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                splashColor: Colors.white70,
                splashRadius: 30,
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(AddProductToWishlist(product: product));

                      const snackBar = SnackBar(
                        content: Text('Added to your Wishlist!'),
                        duration: Duration(milliseconds: 500),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    splashColor: Colors.white70,
                    splashRadius: 30,
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(product: product));
                  const snackBar = SnackBar(
                    content: Text('Added to the cart'),
                    duration: Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text(
                  'ADD TO CART',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.33,
              aspectRatio: 1.6,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              HeroCarouselCard(product: product),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width - 10,
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(16)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '\$${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: ExpansionTile(
              title: Text(
                'Product Information',
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(letterSpacing: 1.0, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: ExpansionTile(
              title: Text(
                'Delivery Information',
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(letterSpacing: 1.0, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
        ],
      ),
    );
  }
}
