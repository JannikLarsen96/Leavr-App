import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import './auth/authservice.dart';
import './main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: PlatformDeviceId.getDeviceId,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: Provider.of<AuthService>(context)
                      .loginUser(snapshot.data),
                  builder: (context, AsyncSnapshot loginResult) {
                    if (loginResult.connectionState == ConnectionState.done) {
                      if (loginResult.hasData &&
                          loginResult.data == snapshot.data) {
                        return LeavRAppHome();
                      } else {
                        return Container(color: Colors.white);
                      }
                    } else {
                      return Container(color: Colors.white);
                    }
                  },
                );
              } else {
                return Container(color: Colors.white);
              }
            } else {
              return Container(color: Colors.white);
            }
          }),
    );
  }
}
