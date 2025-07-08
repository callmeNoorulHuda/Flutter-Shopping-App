import 'package:flutter/material.dart';
import '../screens/buyer/buyer_screen.dart';
import '../screens/seller/seller_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              width: 300,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xFFFFDABA),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login/Signup",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Color(0XFF027373),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellerScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 22),
                              foregroundColor: Colors.black,
                              backgroundColor: const Color(0xFFF28D35),
                            ),
                            child: Text("As a Seller"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuyerScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 22),
                              foregroundColor: Colors.black,
                              backgroundColor: const Color(0xFFF28D35),
                            ),
                            child: Text("As a Buyer"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
