import 'package:cryptovision/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _name = '';

  String _error = "";

  final TextEditingController _tdc_name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
    if (_name != '') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(data: _name)));
    }
  }

  Future<void> _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    setState(() {
      _name = name;
    });
    print(_name);
    if (_name != '') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(data: _name)));
    }
  }

  Future<void> _setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    // print(_name);
    setState(() {
      _name = name;
    });
    if (_name != '') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(data: _name)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                        child: Image(
                            image: Image.asset('assets/crypto.gif').image)),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("Welcome to CryptoVision!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 32,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600))),
                    Text("Please enter your name to get started!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 20),
                      child: TextField(
                        controller: _tdc_name,
                        maxLength: 16,
                        keyboardType: TextInputType.name,
                        enableInteractiveSelection: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade800, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade600, width: 1.5),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        _error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Material(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            onTap: () {
                              String name = _tdc_name.text;
                              if (name != '') {
                                _setName(name);
                              } else {
                                setState(() {
                                  _error = "Please fill your Name!";
                                });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 105),
                                child: Text("Get Started",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 1))))),
                    SizedBox(
                      height: 30,
                    )
                  ]),
                ))));
  }
}
