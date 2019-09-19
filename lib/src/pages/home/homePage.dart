import 'package:flutter/material.dart';
import 'package:forms_validations/src/providers/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(bloc.email?? 'sin datos'), 
            Divider(),
            Text(bloc.password?? 'sin datos')],
        ),
      ),
    );
  }
}
