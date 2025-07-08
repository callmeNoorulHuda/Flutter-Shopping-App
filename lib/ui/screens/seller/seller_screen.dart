import 'package:flutter/material.dart';
import 'package:shopping_cart/authorize/auth_service.dart';
import 'package:shopping_cart/ui/screens/seller/seller_home_screen.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  bool _obscurePass = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formkey,
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
                        const Text(
                          "Seller Login/Signup",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Color(0XFF027373),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: TextFormField(
                              controller: emailCon,
                              validator: (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return 'Required';
                                }
                                bool emailValid = RegExp(
                                  r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$",
                                ).hasMatch(txt);
                                if (!emailValid) {
                                  return "Invalid Email format";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),

                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFF027373),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: passCon,
                              validator: (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                              obscureText: _obscurePass,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePass = !_obscurePass;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  iconSize: 20,
                                ),
                                labelText: "Password",
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),

                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFF027373),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: _logIn,
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFF28D35),
                                ),
                                child: Text("Login"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: _signUp,
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFF28D35),
                                ),
                                child: Text("Sign up"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (formkey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing by tapping outside
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Call signup function
      String? result = await authService.signup(
        emailCon.text.trim(),
        passCon.text.trim(),
        "seller",
      );

      // Dismiss loading dialog
      Navigator.pop(context);

      if (result == "Signup successful") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SellerHomeScreen()),
          (route) => false,
        );
      }

      // Show result in SnackBar
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result ?? "Unknown result")));
      }
    }
  }

  Future<void> _logIn() async {
    if (formkey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing by tapping outside
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Call signup function
      String? result = await authService.login(
        emailCon.text.trim(),
        passCon.text.trim(),
      );

      // Dismiss loading dialog
      Navigator.pop(context);

      if (result != null && result.startsWith("Login successful")) {
        String role = result.split(":")[1];

        if (role == "seller") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SellerHomeScreen()),
            (route) => false,
          );
        } else if (role == "buyer") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registered as a buyer,Try some other mail"),
            ),
          );
        }
      }
      // Show result in SnackBar
      String role = result!.split(":")[1];
      if (mounted && role != "buyer") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result!)));
      }
    }
  }
}
