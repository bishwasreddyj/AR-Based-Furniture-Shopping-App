import 'dart:convert';

import 'package:arfurnitureapp/Models/userdetails.dart';
import 'package:arfurnitureapp/Screens/homepage.dart';
import 'package:arfurnitureapp/Screens/mainhomepage.dart';
import 'package:arfurnitureapp/Screens/register.dart';
import 'package:arfurnitureapp/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController Email_Controller = TextEditingController();
  TextEditingController Password_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: new AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text(
                "Email",
                style: TextStyle(
                  color: Color(0xff3A4453),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            CupertinoTextField(controller: Email_Controller),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
              child: Text(
                "Password",
                style: TextStyle(
                  color: Color(0xff3A4453),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            CupertinoTextField(
              obscureText: true,
              controller: Password_Controller,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: CupertinoButton(
                color: Colors.black,
                child: Center(
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),
                onPressed: () async {
                  EasyLoading.show();
                  final response = await https.post(
                    Uri.parse(Backend.url + "login"),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'email': Email_Controller.text,
                      'password': Password_Controller.text,
                    }),
                  );

                  if (response != null) {
                    EasyLoading.dismiss();
                  }
                  print(response.body);

                  if (response.statusCode == 200) {
                    String token = jsonDecode(response.body)["token"];

                    Fluttertoast.showToast(
                      msg: "Login successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    if (token != null) {
                      userdetails.userEmail = Email_Controller.text;
                      userdetails.authToken = token;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainHomePage()),
                      );
                    }
                  } else {
                    String message = jsonDecode(response.body)["error"];

                    Fluttertoast.showToast(
                      msg: message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: CupertinoButton(
                // color: Colors.black,
                child: Center(
                  child: Text(
                    "Dont Have a Account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
