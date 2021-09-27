import 'package:flutter/material.dart';
import 'package:online_market/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Online Market'),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: Container(),
    );
  }
}
