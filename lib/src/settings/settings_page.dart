import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Switch to"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Get.changeThemeMode(ThemeMode.light),
                  child: const Text("Light Mode"),
                ),
                ElevatedButton(
                  onPressed: () => Get.changeThemeMode(ThemeMode.dark),
                  child: const Text("Dark Mode"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
