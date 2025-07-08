import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyInventory extends StatefulWidget {
  final String? ProductId;
  final String? name;
  final double? price;
  final int? quantity;
  const MyInventory({
    super.key,
    this.ProductId,
    this.name,
    this.price,
    this.quantity,
  });

  @override
  _MyInventoryState createState() => _MyInventoryState();
}

class _MyInventoryState extends State<MyInventory> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  Future<void> addProduct() async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        "name": nameController.text.trim(),
        "price": double.parse(priceController.text.trim()),
        "quantity": int.parse(quantityController.text.trim()),
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product added successfully")));
      nameController.clear();
      priceController.clear();
      quantityController.clear();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error adding product: $e")));
    }
  }

  Future<void> updateProduct(
    String productId,
    String updatedName,
    double updatedPrice,
    int updatedQuantity,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({
            'name': updatedName,
            'price': updatedPrice,
            'quantity': updatedQuantity,
          });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product updated successfully")));
      nameController.clear();
      priceController.clear();
      quantityController.clear();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error adding product: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      nameController.text = widget.name!;
    }
    if (widget.price != null) {
      priceController.text = widget.price!.toString();
    }
    if (widget.quantity != null) {
      quantityController.text = widget.quantity!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Inventory"),
        centerTitle: true,
        backgroundColor: Color(0xFFFFDABA),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: nameController,
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF027373),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF027373),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    labelText: "Quantity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF027373),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: addProduct,
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFF28D35),
                    ),
                    child: Text("Add Product"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Suppose you have TextEditingController for updated fields
                      String updatedName = nameController.text.trim();
                      double updatedPrice = double.parse(
                        priceController.text.trim(),
                      );
                      int updatedQuantity = int.parse(
                        quantityController.text.trim(),
                      );
                      if (widget.ProductId != null) {
                        await updateProduct(
                          widget.ProductId!,
                          updatedName,
                          updatedPrice,
                          updatedQuantity,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Product ID is null. Cannot update."),
                          ),
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Product updated")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFF28D35),
                    ),
                    child: Text("Update Product"),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFDABA),
        height: MediaQuery.of(context).size.height * 0.025,
      ),
    );
  }
}
