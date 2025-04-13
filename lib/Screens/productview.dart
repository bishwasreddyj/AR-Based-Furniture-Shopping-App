// import 'package:artest1/downloaded.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

import 'package:arfurnitureapp/Models/productmodel.dart';
import 'package:arfurnitureapp/Models/userdetails.dart';
import 'package:arfurnitureapp/Screens/createview.dart';
import 'package:arfurnitureapp/api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as https;
// import 'package:artest1/Models/productmodel.dart';

class Productview extends StatefulWidget {
  // const Productview({super.key});
  // Productmodel products= Productmodel;
  Productmodel product;

  Productview({super.key, required this.product});
  @override
  State<Productview> createState() => _ProductviewState();
}

class _ProductviewState extends State<Productview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 46, 46),

      bottomNavigationBar: Container(
        child: Container(
          // color: Colors.amber,
          // height: 10,
          constraints: BoxConstraints(maxHeight: 20),
          width: double.infinity,
          child: CupertinoButton(
            // color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: Colors.black, size: 28),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () async {
              EasyLoading.show();
              String token = userdetails.authToken;

              var response = await https.post(
                Uri.parse(Backend.url + "addtocart"),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },

                body: jsonEncode({'productId': widget.product.productId}),
              );

              if (response != null) {
                EasyLoading.dismiss();
              }

              var respjson = jsonDecode(response.body);

              try {
                Fluttertoast.showToast(msg: respjson["message"]);
              } catch (ee) {}
            },
          ),
        ),

        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffD8D9DA), width: 2)),
        ),
        height: 100,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 187, 255),
        title: Text("Product Details"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                child: CarouselSlider(
                  carouselController: CarouselSliderController(),
                  options: CarouselOptions(
                    disableCenter: true,
                    enableInfiniteScroll: false,
                  ),
                  items:
                      widget.product.images
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(item),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "\$" + widget.product.price.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Container(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Try on space",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Createview(product: widget.product),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Text(
                    "${widget.product.description}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
