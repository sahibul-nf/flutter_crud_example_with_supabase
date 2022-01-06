
import 'package:ecommerce_app/product/controller/product_controller.dart';
import 'package:ecommerce_app/product/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key, required this.name, required this.price, this.id})
      : super(key: key);
  final String name;
  final String price;
  final int? id;

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _keyForm = GlobalKey<FormState>();
  final controller = Get.put(ProductController());

  var nameInputController = TextEditingController();
  var priceInputController = TextEditingController();

  String? nameInput;
  int? priceInput;

  @override
  Widget build(BuildContext context) {
    nameInputController.text = widget.name;
    priceInputController.text = widget.price;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Product"),
      ),
      body: Form(
        key: _keyForm,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              InputTextField(
                inputController: nameInputController,
                title: "Name",
                onChanged: (value) => nameInput = value,
              ),
              const SizedBox(height: 16),
              InputTextField(
                inputController: priceInputController,
                title: "Price",
                onChanged: (value) => priceInput = int.parse(value),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  var res = controller.updateProduct(
                    name: nameInput,
                    price: priceInput,
                    id: widget.id
                  );
                  res.then((value) {
                    if (value) {
                      Get.snackbar("Success", "Succefully update product");
                      controller.fetchProducts();
                    } else {
                      Get.snackbar("Failed", "Opps, failed update product");
                    }
                  });
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
