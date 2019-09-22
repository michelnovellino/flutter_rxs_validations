
import 'package:shared_preferences/shared_preferences.dart';

/*
    instalar paquete:
    shared_preferences:
    Inicializar en el matoken    await prefs.initPrefs();
    
    el main() debe de ser async {...
*/

class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set lastPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}
