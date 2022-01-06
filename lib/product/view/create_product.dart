import 'package:ecommerce_app/product/controller/product_controller.dart';
import 'package:ecommerce_app/product/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _keyForm = GlobalKey<FormState>();
  final controller = Get.put(ProductController());

  var nameInputController = TextEditingController();
  var priceInputController = TextEditingController();

  String? nameInput;
  int? priceInput;

  @override
  Widget build(BuildContext context) {
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
                  var res = controller.createProduct(
                    name: nameInput,
                    price: priceInput,
                  );
                  res.then((value) {
                    if (value) {
                      Get.snackbar("Success", "Succefully create new product");
                      controller.fetchProducts();
                    } else {
                      Get.snackbar("Failed", "Opps, failed create new product");
                    }
                  });
                },
                child: const Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
