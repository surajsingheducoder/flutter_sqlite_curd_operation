import 'package:flutter/material.dart';
import 'package:new_assignment/view/register_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'Email',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                SizedBox(
                  height: 65,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white54,
                    shadowColor: Colors.black,
                    elevation: 10,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Enter your email",
                          border: InputBorder.none,
                          iconColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                          hintStyle:
                          TextStyle(color: Colors.white70, fontSize: 18),
                          prefixIconColor: Colors.white
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                SizedBox(
                  height: 65,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white54,
                    shadowColor: Colors.black,
                    elevation: 10,
                    child: TextField(
                      controller: passwordController,
                      obscureText: !isVisible,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          }, icon: Icon(isVisible? Icons.visibility : Icons.visibility_off)),
                          hintText: "Enter your password",
                          border: InputBorder.none,
                          iconColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                          prefixIconColor: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),

                Center(
                  child: SizedBox(
                    height: 55,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            shape: StadiumBorder()),
                        onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        )),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't you have an Account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),

                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => const RegisterPage(),));
                        },
                        child: Text("Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
