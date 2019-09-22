import 'package:flutter/material.dart';
import 'package:forms_validations/src/pages/404/404.dart';
import 'package:forms_validations/src/pages/home/homePage.dart';
import 'package:forms_validations/src/pages/login/loginPage.dart';
import 'package:forms_validations/src/pages/login/registerPage.dart';
import 'package:forms_validations/src/pages/products/productPage.dart';
import 'package:forms_validations/src/preferences/user.preferences.dart';
import 'package:forms_validations/src/providers/provider.dart';

void main() async {
  runApp(Run());
  final prefs = new UserPreferences();
  await prefs.initPrefs();
}

class Run extends StatelessWidget {
  final _prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {

    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute:( _prefs.token != null) ? '/' : 'login',
      routes: {
        '/': (BuildContext context) {
          return HomePage();
        },
        'login': (BuildContext context) {
          return LoginPage();
        },
        'register': (BuildContext context) {
          return RegisterPage();
        },
        'product': (BuildContext context) {
          return ProductPage();
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return NotFoundPage();
        });
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    ));
  }
}
