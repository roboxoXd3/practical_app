class User{
   String name;
   String email;
  String phone;

  User.fromjson(Map<String, dynamic> parsedJson){
    name = parsedJson['name'];
    email = parsedJson['email'];
    phone = parsedJson['phone'];
  }
}