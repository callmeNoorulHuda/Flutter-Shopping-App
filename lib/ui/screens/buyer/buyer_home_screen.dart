import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/models/Product.dart';
import 'package:shopping_cart/ui/screens/buyer/cart_page.dart';

import '../../../models/cartItem.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  late var checker = 0;
  //var amount;
  late List<CartItem> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDABA),
        centerTitle: true,
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedCart = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage(cart)),
              );

              if (updatedCart != null && updatedCart is List<CartItem>) {
                setState(() {
                  cart = updatedCart.cast<CartItem>();
                });
              }
            },
            icon: Badge(
              label: Text(cart.length.toString()),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final products = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Product(
              doc.id,
              data['name'],
              data['price'],
              data['quantity'],
            );
          }).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isProductInCart = cart
                  .where((element) => element.product.id == product.id)
                  .isNotEmpty;

              return Card(
                child: ListTile(
                  title: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color((0XFF027373)),
                    ),
                  ),
                  subtitle: Text("${product.price}"),
                  trailing: IconButton(
                    onPressed: () => !isProductInCart
                        ? _showAddToCartDialog(context, product)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Product already in cart")),
                          ),
                    color: isProductInCart ? Colors.green : null,
                    icon: Icon(Icons.add_shopping_cart),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFDABA),
        height: MediaQuery.of(context).size.height * 0.025,
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, Product product) {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Column(
                children: [
                  Text("Add ${product.name}"),
                  Text(
                    "Quantity available: ${product.quantity}",
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
                  ),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        setDialogState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text(quantity.toString(), style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setDialogState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    checker = product.quantity - quantity;
                    if (checker < 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Not available"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      product.quantity = product.quantity - quantity;
                      Navigator.pop(context);

                      setState(
                        () {
                          cart.add(
                            CartItem(product: product, quantity: quantity),
                          );
                        },

                        // Debug: Print after adding to cart
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${product.name} x$quantity added to cart",
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Add to Cart"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
