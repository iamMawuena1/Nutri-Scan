import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/components/mybutton.dart';

import '../components/mytextfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  //text editing controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  final allergyController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    allergyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // checking for password visibility
    // bool isObscure = true;

    //login
    void loginScreen() {
      Navigator.pushNamed(context, '/homepage');
    }

    //sign up btn fumction
    void signUpBtn() {}

    return Scaffold(
      backgroundColor: const Color(0xFF860D9A),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //sign up text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create an Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32.0,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Sign up and NutriScan helps you know the food allergens",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    //allergy search
                    MyTextfield(
                      obscureText: false,
                      controller: allergyController,
                      hintText: 'Enter Allergy',
                    ),
                    const SizedBox(height: 10),

                    //emai field
                    MyTextfield(
                      obscureText: false,
                      controller: emailController,
                      hintText: 'Enter Email',
                      validator: (mail) {
                        return !mail!.contains("@")
                            ? "Please enter a valid e-mail"
                            : null;
                      },
                    ),
                    const SizedBox(height: 10),

                    //password field
                    MyTextfield(
                      hintText: 'Enter Password',
                      controller: passwordController,
                      obscureText: true,
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
                    const SizedBox(height: 20),

                    //confirm password
                    MyTextfield(
                      controller: confirmpassController,
                      hintText: 'Confirm Password',
                      obscureText: true,
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

                    //submit btn
                    MyButton(
                      onTap: () => signUpBtn(),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.onPrimary,
                      child: const Text(
                        "Sign Up",
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
                        const Text("Already have an account?"),
                        GestureDetector(
                          child: Text(
                            "  Login",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => loginScreen(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
