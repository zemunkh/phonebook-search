import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


Future<List<String>> fetchFavorites() async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  return _prefs.then((SharedPreferences prefs) {
    return prefs.getStringList('mcaa_favorite_contacts') ?? [];
  });
}


Future<bool> saveFavoriteContact(int index) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final List<String>? favorites = (prefs.getStringList('mcaa_favorite_contacts') ?? []);
  if(favorites!.contains(index.toString())) {
    favorites.removeWhere((item) => item == index.toString());
  } else {
    favorites.add(index.toString());
  }
  print('favorite list 👉: $favorites');
  return prefs.setStringList('mcaa_favorite_contacts', favorites).then((bool success) {
    return success;
  }).catchError((e) => false);
}
