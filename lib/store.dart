import 'package:shared_preferences/shared_preferences.dart';

isExists(str) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("fav")) {
    String temp = prefs.getString("fav")!;
    if (temp.contains(str)) {
      return true;
    } else {
      return false;
    }
  } else {
    prefs.setString("fav", '');
    return false;
  }
}

add(str) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("fav")) {
    prefs.setString("fav", "");
  }
  String data = prefs.getString("fav")!;
  if (!data.contains(str)) {
    data = data + " " + str;
    print(data);
  }
  prefs.setString("fav", data);
}

remove(str) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("fav")) {
    String temp = prefs.getString('fav')!;
    if (temp.contains(str)) {
      temp.replaceAll(str, '');
      print(temp);
      prefs.setString('fav', temp);
    }
  }
}
