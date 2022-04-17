import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../data/contact.dart';


List<User> parseUser(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => User.fromJson(e)).toList();
  return users;
}

Future<List<User>> fetchUsers() async{
  // final http.Response response = await http.get(Uri.parse(url));
  final response = await rootBundle.loadString('assets/contacts.json');

  if (response.isNotEmpty) {
    return compute(parseUser, response);
  } else {
    throw Exception(response);
  }
}
