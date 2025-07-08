import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_cart/models/cartItem.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> products;
  const CheckoutScreen(this.products, {super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool check = false;
  List<CartItem> checkoutitems = [];
  double calculateTotalPrice() {
    double total = 0;
    for (var product in checkoutitems) {
      total += product.product.price * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    late double totalprice = calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout'),

        backgroundColor: Color(0xFFFFDABA),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.products);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final cartItem = widget.products[index];
          final product = cartItem.product;
          final selected = checkoutitems
              .where((element) => element.product.id == product.id)
              .isNotEmpty;
          return Card(
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  _selectItem(cartItem, selected);
                },

                color: selected ? Colors.green : null,
                icon: selected
                    ? Icon(Icons.check_circle_sharp)
                    : Icon(Icons.circle_outlined),
              ),
              title: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color((0XFF027373)),
                ),
              ),
              subtitle: Text("Price:${product.price}"),
              trailing: Text("Qty: ${cartItem.quantity}"),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFDABA),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total:${totalprice}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _placeOrder(check);
                    },
                    child: Text("Place Order", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF28D35),
                      foregroundColor: Colors.black,
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(CartItem cartitem, bool selected) {
    if (!selected) {
      setState(() {
        checkoutitems.add(cartitem);
        check = true;
      });
    } else {
      setState(() {
        checkoutitems.remove(cartitem);
      });
    }
  }

  void _placeOrder(bool selected) {
    if (selected) {
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text("Order Placed"),
            content: Lottie.asset(
              "assets/lottie/Animation - 1751798741681.json",
            ),
          ),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          widget.products.removeWhere(
            (product) => checkoutitems.any(
              (checkedOut) => checkedOut.product.id == product.product.id,
            ),
          );
          checkoutitems.clear();
        });
        Navigator.pop(context, widget.products);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select items to place order")),
      );
    }
  }
}
