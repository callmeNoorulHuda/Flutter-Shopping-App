import 'package:flutter/material.dart';
import 'package:shopping_cart/models/cartItem.dart';
import 'package:shopping_cart/ui/screens/buyer/checkout_screen.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> products;
  const CartPage(this.products, {super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFDABA),
        title: Text("Cart Page"),
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

          return Card(
            //Card forms a card (used for elevation purposes and better ui)
            child: InkWell(
              onTap: () {
                int quantity = 1;
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setDialogState) => AlertDialog(
                      title: Text("Remove item from cart"),
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
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
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
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (quantity == cartItem.quantity) {
                              setState(() {
                                widget.products.remove(cartItem);
                                Navigator.pop(context);
                              });
                            } else {
                              setState(() {
                                cartItem.quantity =
                                    (cartItem.quantity) - quantity;
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Remove"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color((0XFF027373)),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price:${product.price}"),
                    Text("Quantity:${cartItem.quantity}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Are you sure you want to delete this item?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.products.remove(cartItem);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF28D35),
        foregroundColor: Colors.black,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(widget.products),
            ),
          );
          if (result != null && result is List<CartItem>) {
            setState(() {});
          }
        },
        child: Icon(Icons.arrow_forward_outlined),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFDABA),
        height: MediaQuery.of(context).size.height * 0.025,
      ),
    );
  }
}
