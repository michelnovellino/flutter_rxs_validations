import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:forms_validations/src/blocs/validators.dart';

class LoginBloc with Validators {
  final _emailCtrl = BehaviorSubject<String>();
  final _passwordCtrl = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailCtrl.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordCtrl.stream.transform(validatePassword);

Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e, p) {
 
      if ( (e == _emailCtrl.value) && (p == _passwordCtrl.value) ) {
        return true;
      }
 
      return null;
 
    });
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePassword => _passwordCtrl.sink.add;

  //get lastest values

  String get email => _emailCtrl.value;
  String get password => _passwordCtrl.value;

  dispose() {
    _emailCtrl?.close();
    _passwordCtrl?.close();
  }
}
