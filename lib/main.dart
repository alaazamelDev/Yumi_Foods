import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/blocs/cart/cart_bloc.dart';
import 'package:yumi_food/blocs/category/category_bloc.dart';
import 'package:yumi_food/blocs/checkout/checkout_bloc.dart';
import 'package:yumi_food/blocs/product/product_bloc.dart';
import 'package:yumi_food/blocs/wishlist/wishlist_bloc.dart';
import 'package:yumi_food/config/app_router.dart';
import 'package:yumi_food/config/theme.dart';
import 'package:yumi_food/repositories/category/category_repository.dart';
import 'package:yumi_food/repositories/checkout/checkout_repository.dart';
import 'package:yumi_food/repositories/product/product_repository.dart';

import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //lock the orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<WishlistBloc>(
              create: (_) => WishlistBloc()..add(InitializeWishlist())),
          BlocProvider<CartBloc>(
              create: (_) => CartBloc()..add(InitializeCart())),
          BlocProvider<CheckoutBloc>(
            create: (context) => CheckoutBloc(
              checkoutRepository: CheckoutRepository(),
              cartBloc: context.read<CartBloc>(),
            ),
          ),
          BlocProvider<CategoryBloc>(
              create: (_) =>
                  CategoryBloc(categoryRepository: CategoryRepository())
                    ..add(LoadCategories())),
          BlocProvider<ProductBloc>(
              create: (_) => ProductBloc(productRepository: ProductRepository())
                ..add(LoadProducts())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'YUMI FOOD',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
