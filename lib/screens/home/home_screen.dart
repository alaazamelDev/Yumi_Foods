import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumi_food/blocs/category/category_bloc.dart';
import 'package:yumi_food/blocs/product/product_bloc.dart';
import 'package:yumi_food/widgets/widgets.dart';

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
      appBar: const CustomAppBar(title: 'YUMI FOOD'),
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.33,
                      aspectRatio: 1.6,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                      initialPage: 2,
                    ),
                    items: state.categories
                        .map((categroy) => HeroCarouselCard(category: categroy))
                        .toList(),
                  );
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
          const SectionTitle(title: 'RECOMMENDED'),
          //product card
          //ProductCard(product: ,)
          Expanded(
            flex: 2,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products:
                        //show only recommended products
                        state.products
                            .where((product) => product.isRecommended)
                            .toList(),
                  );
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
          const SectionTitle(title: 'MOST POPULAR'),
          Expanded(
            flex: 2,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products:
                        //show only recommended products
                        state.products
                            .where((product) => product.isPopular)
                            .toList(),
                  );
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
