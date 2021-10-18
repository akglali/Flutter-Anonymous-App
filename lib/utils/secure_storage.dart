
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static final storage =  FlutterSecureStorage();

  Future<String?> readKey(String key) async{
    String? value = await storage.read(key: key);
    return value;
  }


  Future writeKey(String key,String uuid) async{
    await storage.write(key: key,value: uuid);
  }

  Future deleteAll()async{
    await storage.deleteAll();
  }
}
