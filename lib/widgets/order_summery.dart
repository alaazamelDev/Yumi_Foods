import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_market/models/models.dart';

class OrderSummery extends StatelessWidget {
  const OrderSummery({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(40),
            vertical: ScreenUtil().setHeight(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SUBTOTAL',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '\$${cart.subtotalString}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DELIVERY FEE',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '\$${cart.deliveryFeeString}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(50),
          decoration: const BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 3,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
              Text(
                '\$${cart.totalString}',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
