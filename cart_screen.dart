//import 'dart:html';

import 'package:famous_footwears/models/cart_item.dart';
import 'package:famous_footwears/providers/cart_provider.dart';
import 'package:famous_footwears/providers/order_provider.dart';
import 'package:famous_footwears/screens/order_screen.dart';
import 'package:famous_footwears/widgets/cart_screen_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//import 'dart:io';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var publicKey = 'pk_test_c840306eac22e823d67101879a37e73e1e1a5a4b';
  final plugin = PaystackPlugin();
  String get getCurrency {
    var format = NumberFormat.simpleCurrency();
    return format.simpleCurrencySymbol('NGN');
  }

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartScreenProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bag'),
        actions: [
          IconButton(
            onPressed: cartScreenProvider.cartFootwears.isEmpty
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Provider.of<Cart>(context, listen: false)
                                  .clearCart();
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                        title: const Text('Remove All Items'),
                        content: const Text(
                            'All Items Will be Removed From Bag. Are You Sure?'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  },
            icon: const Icon(Icons.delete_outline_rounded),
            color: Theme.of(context).errorColor,
          ),
        ],
        titleTextStyle: const TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
        iconTheme: const IconThemeData(size: 35),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartScreenProvider.cartFootwears.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/lottie/unknown6.json'),
                        // const SizedBox(height: 20,),
                        const Text(
                          'Your bag is empty, add items!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => CartScreenItem(
                      id: cartScreenProvider.cartFootwears.values
                          .toList()[index]
                          .id,
                      footwearId:
                          cartScreenProvider.cartFootwears.keys.toList()[index],
                      name: cartScreenProvider.cartFootwears.values
                          .toList()[index]
                          .name,
                      imageUrl: cartScreenProvider.cartFootwears.values
                          .toList()[index]
                          .imageUrl,
                      quantity: cartScreenProvider.cartFootwears.values
                          .toList()[index]
                          .quantity,
                      price: cartScreenProvider.cartFootwears.values
                          .toList()[index]
                          .price,
                    ),
                    itemCount: cartScreenProvider.cartFootwears.length,
                  ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$getCurrency ${cartScreenProvider.totalAmount}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25.0,
              top: 5,
            ),
            child: ElevatedButton(
              onPressed: cartScreenProvider.cartFootwears.isEmpty
                  ? null
                  : () => _tryPaystack(
                        cartScreenProvider.cartFootwears.values.toList(),
                        cartScreenProvider.totalAmount,
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                fixedSize: const Size(180, 55),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // int get totalAmount {
  //   return Provider.of<Cart>(context).totalAmount.toInt();
  // }

  // // Charge charge = Charge()
  // //   ..amount =
  // //   ..currency = 'NGN'
  // //   ..reference = DateTime.now().toString()
  // //   ..email = 'omobolajibaruwa@gmail.com';

  Future<void> _tryPaystack(List<CartItem> cartItems, double total) async {
    Charge charge = Charge()
      ..amount = total.toInt() * 100
      ..currency = 'NGN'
      ..reference = DateTime.now().toString()
      ..email = 'omobolajibaruwa@gmail.com';

    CheckoutResponse response = await plugin.checkout(
      context,
      charge: charge,
      fullscreen: true,
      method: CheckoutMethod.card,
      // logo: Image.asset('assets/images/logo.png'),
    );

    if (response.status == true) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: SizedBox(
            height: 420,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Lottie.asset(
                    'assets/lottie/order_accepted.json',
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'Order Confirmed!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Continue shopping'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(OrderScreen.routeName);
                        },
                        child: const Text('Go to orders'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
      // Provider.of<Order>(context, listen: false).addOrder(cartItems, total);
      Provider.of<Cart>(context, listen: false).clearCart();
    }

    // print(response.status);
  }
}
