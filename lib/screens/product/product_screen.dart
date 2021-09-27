import 'package:flutter/material.dart';
import 'package:online_market/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ProductScreen(),
    );
  }

  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product'),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: Container(),
    );
  }
}
