import 'package:arfurnitureapp/Models/productmodel.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';

class Createview extends StatefulWidget {
  // const Createview({super.key});
  Productmodel product;

  Createview({required this.product});

  @override
  State<Createview> createState() => _CreateviewState();
}

class _CreateviewState extends State<Createview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Place on space",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: AugmentedRealityPlugin('${widget.product.arModel}'),
    );
  }
}
