import 'package:ecommerce_app/product/controller/product_controller.dart';
import 'package:ecommerce_app/product/view/create_product.dart';
import 'package:ecommerce_app/product/view/update_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    controller.fetchProducts();

    return Scaffold(
        appBar: AppBar(
          title: const Text("CRUD Product"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const CreateProduct());
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            controller.products.clear();
            return controller.fetchProducts();
          },
          child: Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 10),
                      for (var product in controller.products)
                        Container(
                          height: 75,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.name}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("\$${product.price}"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      Get.to(
                                        UpdateProduct(
                                          name: product.name.toString(),
                                          price: product.price.toString(),
                                          id: product.id,
                                        ),
                                      );
                                    },
                                    color: Colors.black,
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "🙁",
                                        titleStyle: const TextStyle(
                                          fontSize: 40,
                                        ),
                                        middleText:
                                            "Are you sure delete this product?",
                                        confirm: ElevatedButton(
                                          onPressed: () {
                                            var res = controller
                                                .deleteProduct(product.id);
                                            res.then((value) {
                                              if (value) {
                                                setState(() {
                                                  Get.snackbar(
                                                    "Success",
                                                    "Succefully delete product",
                                                  );
                                                });
                                              } else {
                                                setState(() {
                                                  Get.snackbar(
                                                    "Failed",
                                                    "Opps, failed delete product",
                                                  );
                                                });
                                              }
                                            });
                                            Get.back();
                                          },
                                          child: const Text("Delete"),
                                        ),
                                        cancel: OutlinedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      );
                                    },
                                    color: Colors.red,
                                    icon: const Icon(
                                      Icons.highlight_remove,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
          }),
        ));
  }
}
