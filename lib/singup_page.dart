/*
import './auth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Opret bruger!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Opret en bruger - det er gratis!",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            TextFormField(
                                onSaved: (value) => _email = value,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    const InputDecoration(labelText: "Email")),
                            TextFormField(
                                onSaved: (value) => _password = value,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: "Kodeord")),
                            TextFormField(
                                onSaved: (value) => _confirmPassword = value,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Bekræft Kodeord")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              final form = _formKey.currentState;
                              form?.save();
                              if (form?.validate() ?? false) {
                                Provider.of<AuthService>(context, listen: false)
                                    .createUser(_email ?? '', _password ?? '',
                                        _confirmPassword ?? '');
                                Navigator.pop(context);
                              }
                            },
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: const Text(
                              "Opret bruger",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/