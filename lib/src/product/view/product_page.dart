import 'package:ecommerce_app/src/product/controller/product_controller.dart';
import 'package:ecommerce_app/src/product/view/create_product.dart';
import 'package:ecommerce_app/src/product/view/update_product.dart';
import 'package:ecommerce_app/src/product/widgets/product_card.dart';
import 'package:ecommerce_app/src/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

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
          actions: [
            IconButton(
              onPressed: () {
                Get.to(const SettingsPage());
              },
              icon: const Icon(Icons.settings),
            )
          ],
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
                        ProductCard(
                          name: product.name,
                          price: product.price,
                          goToUpdate: () {
                            Get.to(
                              UpdateProduct(
                                name: product.name.toString(),
                                price: product.price.toString(),
                                id: product.id,
                              ),
                            );
                          },
                          confirmDelete: () {
                            var res = controller.deleteProduct(product.id);
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
                        )
                    ],
                  );
          }),
        ));
  }
}
