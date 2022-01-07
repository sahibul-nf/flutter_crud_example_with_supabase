import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/product/model/product_model.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class ProductController extends GetxController {
  final client = SupabaseClient(
    "https://aweyauscviogpvaccrbl.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MTQ2NjE2NywiZXhwIjoxOTU3MDQyMTY3fQ.l2FSozoryhfkP4CUQVFY3wADUU1xQlfc3ESvAIcFtcA",
  );

  @override
  void onInit() {
    super.onInit();
    // fetchProducts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final _products = <ProductModel>[].obs;
  List<ProductModel> get products => _products();
  var isLoading = true.obs;

  Future fetchProducts() async {
    try {
      final response = await client.from('Product').select('*').execute();

      if (response.data != null) {
        var data = response.data;
        for (var json in (data as List)) {
          var product = ProductModel.fromJson(json);
          _products.add(product);
        }
        isLoading.value = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteProduct(int? id) async {
    final response =
        await client.from('Product').delete().match({'id': id}).execute();

    if (response.data != null) {
      if (response.data.toString() == '[]') {
        return false;
      }
      _products.clear();
      return true;
    } else {
      return true;
    }
  }

  Future createProduct({String? name, int? price}) async {
    final response = await client
        .from('Product')
        .insert({"name": name, "price": price}).execute();

    if (response.data != null) {
      _products.clear();
      return true;
    } else {
      return false;
    }
  }

  Future updateProduct({String? name, int? price, int? id}) async {
    final response = await client
        .from('Product')
        .update({'name': name, 'price': price}).match({'id': id}).execute();

    if (response.data != null) {
      _products.clear();
      return true;
    } else {
      return false;
    }
  }
}
