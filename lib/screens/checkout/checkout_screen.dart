import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumi_food/blocs/cart/cart_bloc.dart';
import 'package:yumi_food/blocs/checkout/checkout_bloc.dart';
import 'package:yumi_food/screens/home/home_screen.dart';
import 'package:yumi_food/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  CheckoutScreen({Key? key}) : super(key: key);
  final List<bool> isEmpty = List.generate(6, (index) => true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: ScreenUtil().setHeight(60),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                if (state is CheckoutLoaded) {
                  return ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < isEmpty.length; i++) {
                        if (isEmpty[i]) {
                          var snackBar = const SnackBar(
                            content: Text('check your information!'),
                            duration: Duration(
                              milliseconds: 500,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                      }
                      context
                          .read<CheckoutBloc>()
                          .add(ConfirmCheckout(checkout: state.checkout));
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Text(
                      'ORDER NOW',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                }
                if (state is CheckoutCompleted) {
                  return ElevatedButton(
                    onPressed: () {
                      //go directly to home screen
                      Future.delayed(const Duration(seconds: 0), () {
                        context.read<CheckoutBloc>().add(ResetCheckout());
                      });
                      Navigator.pushAndRemoveUntil(
                          context, HomeScreen.route(), (route) => false);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Text(
                      'GO TO HOME SCREEN',
                      style: Theme.of(context).textTheme.headline4,
                    ),
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
          ),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (_, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is CheckoutCompleted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/done.png',
                  scale: 2.5,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  'Your Order Has Been\nSubmitted Successfully',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16.sp, height: 1.5),
                )
              ],
            );
          }
          if (state is CheckoutLoaded) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SectionTitle(title: 'CUSTOMER INFORMATION'),
                    _buildTextFormField(
                      context: context,
                      label: 'Email',
                      inputType: TextInputType.emailAddress,
                      onChanged: (value) {
                        isEmpty[0] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(email: value));
                      },
                    ),
                    _buildTextFormField(
                      context: context,
                      label: 'Full Name',
                      inputType: TextInputType.name,
                      onChanged: (value) {
                        isEmpty[1] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(fullname: value));
                      },
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    const SectionTitle(title: 'DELIVERY INFORMATION'),
                    _buildTextFormField(
                      context: context,
                      label: 'Address',
                      onChanged: (value) {
                        isEmpty[2] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(address: value));
                      },
                    ),
                    _buildTextFormField(
                      context: context,
                      label: 'City',
                      onChanged: (value) {
                        isEmpty[3] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(city: value));
                      },
                    ),
                    _buildTextFormField(
                      context: context,
                      label: 'Country',
                      onChanged: (value) {
                        isEmpty[4] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(country: value));
                      },
                    ),
                    _buildTextFormField(
                      context: context,
                      label: 'ZIP Code',
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        isEmpty[5] = value.isEmpty;
                        context
                            .read<CheckoutBloc>()
                            .add(UpdateCheckout(zipCode: value));
                      },
                    ),
                    PaymentButton(onPressed: () {}),
                    const SectionTitle(title: 'ORDER SUMMARY'),
                    const SectionDivider(thinkness: 2),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (state is CartLoaded) {
                          return OrderSummery(
                            cart: state.cart,
                          );
                        } else {
                          return const Center(
                              child: Text('Something went wrong!'));
                        }
                      },
                    ),
                  ],
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

  Widget _buildTextFormField({
    required BuildContext context,
    required String label,
    required Function(String) onChanged,
    TextInputType? inputType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(10),
          horizontal: ScreenUtil().setWidth(20)),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(70),
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              keyboardType: inputType,
            ),
          ),
        ],
      ),
    );
  }
}
