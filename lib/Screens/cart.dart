import 'dart:convert';

import 'package:arfurnitureapp/Models/productmodel.dart';
import 'package:arfurnitureapp/Models/userdetails.dart';
import 'package:arfurnitureapp/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Productmodel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Your Cart")),

      body:
          products.length > 0
              ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Productmodel thisproduct = products[index];
                  return ListTile(
                    tileColor: Colors.amber,
                    leading: Image.network(thisproduct.images[0]),
                    title: Text(thisproduct.title),
                    trailing: CupertinoButton(
                      child: Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        String token = userdetails.authToken;

                        var response = await https.post(
                          Uri.parse(Backend.url + "removefromcart"),

                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token',
                          },

                          body: jsonEncode({
                            'productId': thisproduct.productId,
                          }),
                        );

                        var responsejson = jsonDecode(response.body);
                        try {
                          Fluttertoast.showToast(
                            msg: responsejson["message"],
                            textColor: Colors.green,
                          );
                          getCartDetails();
                        } catch (ee) {
                          Fluttertoast.showToast(
                            msg: responsejson["error"],
                            textColor: Colors.red,
                          );
                        }
                      },
                    ),
                  );
                },
              )
              : Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Container(
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/11329/11329060.png",
                    ),
                  ),
                ),
              ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartDetails();
  }

  Future<void> getCartDetails() async {
    String token = userdetails.authToken;
    EasyLoading.show();
    var result = await https.get(
      Uri.parse(Backend.url + "cart"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (result != null) {
      EasyLoading.dismiss();
    }
    var results = jsonDecode(result.body);

    if (results.length > 0) {
      List<dynamic> jsonList = json.decode(result.body);
      print(jsonList);
      List<Productmodel> products_ =
          jsonList.map((item) => Productmodel.fromJson(item)).toList();
      setState(() {
        products = products_;
      });
    } else {
      setState(() {
        products = [];
      });
    }
  }
}
