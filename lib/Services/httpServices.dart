
import 'package:http/http.dart' as http;
import 'package:practical_app/Model/User.dart';

import 'dart:convert';



class HttpServices {

  static String userUrl = "https://jsonplaceholder.typicode.com/users";

  static Future<List<User>> fetchUsers({query}) async {
    http.Response res = await http.get(userUrl);

    ///res.body se content k andr wo long string aa gyi jo ki ek list h lekin abi b usko dart m use krne k liye decode krna pdega;
    String content = res.body;

    ///yha hm decode b kr rhe aur save b kr rhe ek local List k andr.
    List collection = json.decode(content);
    Iterable<User> _users = collection.map((e) => User.fromjson(e));
    if (query != null && query.isNotEmpty) {
      _users =
          _users.where((element) => element.name.toLowerCase().contains(query));
    }
    return _users.toList();
  }

  // static Future<List<CropModel>> fetchCrops({query}) async {
  //   http.Response res = await http.get(url);
  //
  //   String content = res.body;
  //   List collection = json.decode(content);
  //
  //   Iterable<CropModel> _crops = collection.map((e) => CropModel.fromJson(e));
  //   if (query != null && query.isNotEmpty) {
  //     _crops = _crops
  //         .where((element) => element.Crop_name.toLowerCase().contains(query));
  //   }
  //   return _crops.toList();
  // }
  //
  // static Future<List<Product>> fetchItems({query}) async {
  //   http.Response res = await http.get(itemsUrl);
  //
  //   String content = res.body;
  //   List collection = json.decode(content);
  //
  //   Iterable<Product> _items = collection.map((e) => Product.fromJson(e));
  //   if (query != null && query.isNotEmpty) {
  //     _items = _items.where(
  //         (element) => element.Crop_name_store.toLowerCase().contains(query));
  //   }
  //   return _items.toList();
  // }
}

void main() async {
  List result = await HttpServices.fetchUsers();
  print(result);
}
