import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10),
        horizontal: ScreenUtil().setWidth(20),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(10),
            horizontal: ScreenUtil().setWidth(15),
          ),
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'SELECT A PAYMENT METHOD',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
