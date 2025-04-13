import 'dart:convert';

import 'package:arfurnitureapp/Screens/login.dart';
import 'package:arfurnitureapp/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController Email_Controller = TextEditingController();
  TextEditingController Password_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(title: Text("Register"), backgroundColor: Colors.red),
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
                  fontWeight: FontWeight.w600,
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
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  EasyLoading.show();
                  final response = await https.post(
                    Uri.parse(Backend.url + "register"),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'email': Email_Controller.text,
                      'password': Password_Controller.text,
                    }),
                  );

                  print(response.body);
                  if (response != null) {
                    EasyLoading.dismiss();
                  }

                  if (response.statusCode == 200) {
                    String message = jsonDecode(response.body)["message"];

                    Fluttertoast.showToast(
                      msg: message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    if (message == "User registered") {
                      Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
