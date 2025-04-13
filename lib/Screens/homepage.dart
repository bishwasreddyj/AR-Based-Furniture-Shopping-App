// import 'package:artest1/Models/productmodel.dart';
// import 'package:artest1/Screens/productview.dart';
// import 'package:artest1/downloaded.dart';
import 'dart:convert';

import 'package:arfurnitureapp/Models/productmodel.dart';
import 'package:arfurnitureapp/Screens/cart.dart';
import 'package:arfurnitureapp/Screens/productview.dart';
import 'package:arfurnitureapp/api.dart';
import 'package:arfurnitureapp/downloaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as https;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Ar Furniture Store"),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 8, // Space between columns
            mainAxisSpacing: 8, // Space between rows
          ),
          itemCount: DownloadedData.products.length, // Number of items
          itemBuilder: (context, index) {
            Productmodel product = DownloadedData.products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Productview(
                          product: DownloadedData.products[index],
                        ),
                  ),
                );
              },
              child: FurnitureItem(
                imageUrl: product.images[0],
                title: product.title,
                price: product.price.toString(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getproducts();
  }

  Future<void> getproducts() async {
    EasyLoading.show();
    var result = await https.get(Uri.parse(Backend.url + "getallproducts"));
    if (result != null) {
      EasyLoading.dismiss();
    }
    if (result.statusCode == 200) {
      List<dynamic> jsonList = json.decode(result.body);
      print(jsonList);
      List<Productmodel> products =
          jsonList.map((item) => Productmodel.fromJson(item)).toList();
      setState(() {
        DownloadedData.products = products;
      });
    }
  }
}

class FurnitureItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const FurnitureItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 85, 255),
        borderRadius: BorderRadius.circular(12),
      ),

      // elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Center(
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "\$$price",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
