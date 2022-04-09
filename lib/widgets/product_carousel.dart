import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/models/models.dart';
import 'package:yumi_food/widgets/widgets.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  const ProductCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.21,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(10),
          horizontal: ScreenUtil().setWidth(15),
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ProductCard(
            product: products[index],
            widthFactor: 2.2,
          ),
        ),
      ),
    );
  }
}
