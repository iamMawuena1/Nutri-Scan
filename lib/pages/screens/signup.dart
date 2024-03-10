import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/components/mybutton.dart';

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

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // checking for password visibility
    bool isObscure = true;

    //login
    void loginScreen() {
      Navigator.pushNamed(context, '/login');
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
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                          suffixIconColor:
                              Theme.of(context).colorScheme.onPrimary,
                          suffixIcon: IconButton(
                            icon: Icon(
                              // ignore: dead_code
                              isObscure
                                  ? Icons.visibility_off
                                  // ignore: dead_code
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
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

                    //confirm password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                          suffixIconColor:
                              Theme.of(context).colorScheme.onPrimary,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
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

                    //submit btn
                    MyButton(
                      onTap: () => signUpBtn(),
                      padding: const EdgeInsets.all(20),
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
