import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _name, _age, _email, _city, _country, _phoneNumber, _password;

  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var emailController = new TextEditingController();
  var cityController = new TextEditingController();
  var countryController = new TextEditingController();
  var phoneNumberController = new TextEditingController();
  var passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is Required";
                        }
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(labelText: "Age"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age is Required";
                        }
                      },
                      onSaved: (value) {
                        _age = value;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is Required";
                        }
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(labelText: "City"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "City is Required";
                        }
                      },
                      onSaved: (value) {
                        _city = value;
                      },
                    ),
                    TextFormField(
                      controller: countryController,
                      decoration: InputDecoration(labelText: "Country"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Country is Required";
                        }
                      },
                      onSaved: (value) {
                        _country = value;
                      },
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(labelText: "Phone Number"),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone Number is Required";
                        }
                      },
                      onSaved: (value) {
                        _phoneNumber = value;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is Required";
                        }
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();

                          if (nameController.text.isNotEmpty &&
                              ageController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              cityController.text.isNotEmpty &&
                              countryController.text.isNotEmpty &&
                              phoneNumberController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            insertData(
                                nameController.text,
                                ageController.text,
                                emailController.text,
                                cityController.text,
                                countryController.text,
                                phoneNumberController.text,
                                passwordController.text);
                          }

                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  content: Text("Saved Successfully"),
                                );
                              });
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 16.0),
                        )),
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void insertData(String name, String age, String email, String city,
      String country, String phoneNumber, String password) {
    String key = databaseRef.child("path").push().key;
    databaseRef.child("path").child(key).set({
      "id": key,
      'name': name,
      'age': age,
      'email': email,
      'city': city,
      'country': country,
      'phoneNumber': phoneNumber,
      'password': password,
    });
    nameController.clear();
    ageController.clear();
    emailController.clear();
    cityController.clear();
    countryController.clear();
    phoneNumberController.clear();
    passwordController.clear();
  }
}
