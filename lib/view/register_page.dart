import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_assignment/view/dashboard.dart';
import 'package:sqflite/sqflite.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isVisible = false;

  validateField(){
    if(nameController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter name");
    }
    else if(emailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter email");
    }
    else if(!emailController.text.contains("@gmail.com")){
      Fluttertoast.showToast(msg: "email must be contains @gmail.com");
    }
    else if(dobController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter Date of Birth");
    }
    else if(passwordController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter password");
    }
    else if(passwordController.text.length < 8){
      Fluttertoast.showToast(msg: "Password should be 8 character");
    }
    else if(confirmPasswordController.text.isEmpty || confirmPasswordController.text.length < 8){
      Fluttertoast.showToast(msg: "Please Enter Confirm password");
    }
    else if(passwordController.text == confirmPasswordController.text){
      Fluttertoast.showToast(msg: "Register Successful");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
    }
    else{
      Fluttertoast.showToast(msg: "Password is not match");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Name',
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
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter your name",
                        border: InputBorder.none,
                        iconColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                        prefixIconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
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
                        hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                        prefixIconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Date of Birth',
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
                      controller: dobController,
                      keyboardType: TextInputType.datetime,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        hintText: "01/01/2000",
                        border: InputBorder.none,
                        iconColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                        prefixIconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
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
                      decoration: InputDecoration(
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
                        prefixIconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Confirm Password',
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
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isVisible,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        }, icon: Icon(isVisible? Icons.visibility : Icons.visibility_off)),
                        hintText: "Enter confirm password",
                        border: InputBorder.none,
                        iconColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                        prefixIconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: 55,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                      validateField();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "If you have already account",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


