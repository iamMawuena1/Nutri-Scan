import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/components/mybutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  //sign up
  void signUpScreen() {
    Navigator.pushNamed(context, '/signup');
  }

  //login btn
  void loginBtn() {
    // if (_formkey.currentState!.validate()) {
    //   _formkey.currentState!.save();
    // }
    Navigator.pushNamed(context, '/homepage');
  }

  //checking for text obscurity
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF860D9A),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //login text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Login and NutriScan helps you know the food allergens",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  //emai field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        hintText: 'Enter E-mail',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      validator: (mail) {
                        return !mail!.contains("@")
                            ? "Please enter a valid e-mail"
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  //password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        suffixIconColor:
                            Theme.of(context).colorScheme.onPrimary,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (password) {
                        if (password == null || password.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (password.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  //submit btn
                  MyButton(
                    onTap: () => loginBtn(),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //sign up session
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        child: Text(
                          "  Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => signUpScreen(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
