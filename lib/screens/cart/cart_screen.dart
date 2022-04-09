import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/blocs/cart/cart_bloc.dart';
import 'package:yumi_food/screens/checkout/checkout_screen.dart';
import 'package:yumi_food/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CartScreen(),
    );
  }

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: ScreenUtil().setHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state.cart.products.isNotEmpty) {
                          Navigator.pushNamed(
                              context, CheckoutScreen.routeName);
                        } else {
                          var snackBar = const SnackBar(
                            content: Text(
                              'make sure to select some products.',
                            ),
                            duration: Duration(milliseconds: 500),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Text(
                        'GO TO CHECKOUT',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    );
                  }
                  if (state is CartLoading) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  } else {
                    return Text(
                      'Something went wrong!',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.red),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            );
          }
          if (state is CartLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.cart.freeDeliveryString,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 13.sp),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Add More Items',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Colors.white, fontSize: 13.sp),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: state.cart
                              .productQuantity(state.cart.products)
                              .keys
                              .length,
                          itemBuilder: (context, index) => CartProductCard(
                            product: state.cart
                                .productQuantity(state.cart.products)
                                .keys
                                .elementAt(index),
                            quantity: state.cart
                                .productQuantity(state.cart.products)
                                .values
                                .elementAt(index),
                          ),
                        ),
                      ),
                      const Divider(thickness: 1),
                      OrderSummery(cart: state.cart),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Something went wrong!\ntry again later.',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
