import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_market/blocs/product/product_bloc.dart';
import 'package:online_market/models/models.dart';
import 'package:online_market/widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  const CatalogScreen({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is ProductLoaded) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(5),
                vertical: ScreenUtil().setHeight(15),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
              ),
              itemCount: state.products
                  .where((product) => product.category == category.name)
                  .length,
              itemBuilder: (context, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ProductCard(
                    product: state.products
                        .where((product) => product.category == category.name)
                        .elementAt(index),
                    widthFactor: 2.2,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
