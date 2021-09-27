import 'package:flutter/material.dart';
import 'package:online_market/widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CatalogScreen(),
    );
  }

  const CatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Catalog'),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: Container(),
    );
  }
}
