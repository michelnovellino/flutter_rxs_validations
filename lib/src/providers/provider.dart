import 'package:flutter/material.dart';
import 'package:forms_validations/src/blocs/login.bloc.dart';
export 'package:forms_validations/src/blocs/login.bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
  final LoginBloc loginBloc = LoginBloc();
/*  
estas lineas comentadas funcionan perfectamente sin lo que esta arriba,
solamente que cuando se ejecuta build de un widget la instancia se vuelve a crear,
la configuracion de arriba nos permite tener datos persistentes en desarrollo
para debugear de forma mas rapida, lo que esta comentado funciona perfectamente en produccion
si se borra lo de arriba.

 final LoginBloc loginBloc = LoginBloc();
 */
/*   Provider({Key key, Widget child}) : super(key: key, child: child);
 */
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }
}
