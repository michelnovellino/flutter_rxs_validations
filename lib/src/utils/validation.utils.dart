import 'package:flutter/material.dart';

bool isNum (String value){
  if (value.isEmpty) return false;
  final n = num.tryParse(value);
  return (n == null) ? false : true;
}


showAlert(BuildContext context,String message){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}