part of 'config.dart';

class SaveData {
  static SharedPreferences? data;

  static Future<SharedPreferences?> loadData() async {
    await SharedPreferences.getInstance().then((value) {
      data = value;
    });

    return data;
  }
}
