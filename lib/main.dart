import 'package:flutter/material.dart';
import 'package:forms_validations/src/pages/404/404.dart';
import 'package:forms_validations/src/pages/home/homePage.dart';
import 'package:forms_validations/src/pages/login/loginPage.dart';
import 'package:forms_validations/src/pages/login/registerPage.dart';
import 'package:forms_validations/src/pages/products/productPage.dart';
import 'package:forms_validations/src/providers/provider.dart';

void main() => runApp(Run());

class Run extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
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
