import 'dart:io';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../auth/authservice.dart';
import 'package:flutter/material.dart';

class ApiClientBase {
  static Future<http.Response> get(BuildContext context, Uri url,
      {Map<String, String>? headers}) async {
    var user = await Provider.of<AuthService>(context, listen: false).getUser();
    var token = _getToken(user?.id ?? -1);

    //TODO: Add error handling

    var httpHeaders = Map<String, String>();

    httpHeaders.addAll({HttpHeaders.authorizationHeader: 'Bearer ' + token});
    httpHeaders.addAll({HttpHeaders.contentTypeHeader: "application/json"});
    if (headers != null && headers.isNotEmpty) {
      httpHeaders.addAll(headers);
    }

    var httpResult = await http.get(url, headers: httpHeaders);

    return httpResult;
  }

  static Future<http.Response> post(BuildContext context, Uri url,
      {Map<String, String>? headers, Object? body}) async {
    var user = await Provider.of<AuthService>(context, listen: false).getUser();
    var token = _getToken(user?.id ?? -1);

    //TODO: Add error handling

    var httpHeaders = Map<String, String>();

    httpHeaders.addAll({HttpHeaders.authorizationHeader: 'Bearer ' + token});
    httpHeaders.addAll({HttpHeaders.contentTypeHeader: "application/json"});
    if (headers != null && headers.isNotEmpty) {
      httpHeaders.addAll(headers);
    }

    var httpResult = await http.post(url, headers: httpHeaders, body: body);

    return httpResult;
  }

  static Future<http.Response> delete(BuildContext context, Uri url,
      {Map<String, String>? headers, Object? body}) async {
    var user = await Provider.of<AuthService>(context, listen: false).getUser();
    var token = _getToken(user?.id ?? -1);

    //TODO: Add error handling

    var httpHeaders = Map<String, String>();

    httpHeaders.addAll({HttpHeaders.authorizationHeader: 'Bearer ' + token});
    httpHeaders.addAll({HttpHeaders.contentTypeHeader: "application/json"});
    if (headers != null && headers.isNotEmpty) {
      httpHeaders.addAll(headers);
    }

    var httpResult = await http.delete(url, headers: httpHeaders, body: body);

    return httpResult;
  }

  static String _getToken(int userId) {
    final claimSet = JwtClaim(
        issuer: 'LeavR Flutter App',
        issuedAt: DateTime.now(),
        maxAge: const Duration(hours: 12),
        otherClaims: <String, dynamic>{'userId': userId});

    const String secret =
        'YeLurEQbY9Cb8I2ktN4kRrYLCwdUFeO4WEkR1cweUI24dwy5zNvDNPi3bQk3IgO87Fn07lg1UCsaHqsij4kQiG35ttrZU9C3s45h';
    String token = issueJwtHS256(claimSet, secret);
    return token;
  }
}
