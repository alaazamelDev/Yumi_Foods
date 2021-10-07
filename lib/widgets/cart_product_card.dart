import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_market/blocs/cart/cart_bloc.dart';
import 'package:online_market/models/models.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    Key? key,
    required this.quantity,
    required this.product,
  }) : super(key: key);
  final Product product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(80),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: ScreenUtil().setHeight(5)),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCart(product: product));
                    },
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(5)),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Text(
                        '$quantity',
                        style: Theme.of(context).textTheme.headline5,
                      );
                    },
                  ),
                  SizedBox(width: ScreenUtil().setWidth(5)),
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCart(product: product));
                    },
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
