import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapon_classification/model/api/weapon_api.dart';
import 'package:weapon_classification/model/weapon_model.dart';

enum WeaponViewState {
  none,
  loading,
  error,
}

class WeaponViewModel with ChangeNotifier {
  WeaponViewState _state = WeaponViewState.none;
  WeaponViewState get state => _state;

  List<Weapon> _weapons = [];
  List<Weapon> get weapons => _weapons;

  // ignore: non_constant_identifier_names
  ChangeState(WeaponViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllWeapons() async {
    ChangeState(WeaponViewState.loading);

    try {
      final c = await WeaponAPI.getAllWeapons();
      _weapons = c;
      notifyListeners();
      ChangeState(WeaponViewState.none);
    } catch (e) {
      ChangeState(WeaponViewState.error);
    }
  }
}
