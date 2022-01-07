import 'package:ecommerce_app/src/product/view/product_page.dart';
import 'package:ecommerce_app/src/settings/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const ProductPage(),
    );
  }
}
