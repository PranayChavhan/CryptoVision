import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWishlist extends StatefulWidget {
  const AddWishlist({Key? key}) : super(key: key);

  @override
  State<AddWishlist> createState() => _AddWishlistState();
}

class _AddWishlistState extends State<AddWishlist> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late TextEditingController _inputController;

  Future<void> _setValue(double updateValue) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('counter', updateValue);
  }

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            TextButton(
                onPressed: (){
                  _setValue(_inputController.value as double);
                },
                child: Text("Set Alert"))
          ],
        ),
      )
    );
  }
}
