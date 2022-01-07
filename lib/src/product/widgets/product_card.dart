import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, this.name, this.price, this.goToUpdate, this.confirmDelete})
      : super(key: key);
  final String? name;
  final int? price;
  final void Function()? goToUpdate;
  final void Function()? confirmDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\$$price",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: goToUpdate,
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
                    middleText: "Are you sure delete this product?",
                    confirm: ElevatedButton(
                      onPressed: confirmDelete,
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
    );
  }
}
