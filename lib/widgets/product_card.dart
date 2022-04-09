import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/blocs/cart/cart_bloc.dart';
import 'package:yumi_food/blocs/wishlist/wishlist_bloc.dart';
import 'package:yumi_food/models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.5,
    this.leftPostion = 10,
    this.isWishlist = false,
  }) : super(key: key);
  final Product product;
  final double widthFactor;
  final double leftPostion;
  final bool isWishlist;

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: widthValue,
              height: ScreenUtil().setHeight(150),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: leftPostion,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
                color: Colors.black.withOpacity(0.6),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
              width: widthValue - ScreenUtil().setWidth(10) - leftPostion,
              height: ScreenUtil().setHeight(52),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Expanded(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(AddToCart(product: product));
                            const snackBar = SnackBar(
                              content: Text('Added to the cart'),
                              duration: Duration(milliseconds: 500),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  isWishlist
                      ? Expanded(
                          child: BlocBuilder<WishlistBloc, WishlistState>(
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  context.read<WishlistBloc>().add(
                                      RemoveProductFromWishlist(
                                          product: product));
                                },
                                splashRadius: 20,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
