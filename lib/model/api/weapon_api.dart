import 'package:dio/dio.dart';
import 'package:weapon_classification/model/weapon_model.dart';

class WeaponAPI {
  static Future<List<Weapon>> getAllDiseases() async {
    final response = await Dio().get(
        'https://my-json-server.typicode.com/dhaifan999/weapon_classification/weapon');

    List<Weapon> weapons = (response.data as List)
        .map(
          (e) => Weapon(
              id: e['id'], name: e['name'], description: e['description']),
        )
        .toList();

    return weapons;
  }
}
