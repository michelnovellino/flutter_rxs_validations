import 'package:flutter/material.dart';
import 'package:forms_validations/src/providers/provider.dart';
import 'package:forms_validations/src/providers/user.provider.dart';

class RegisterPage extends StatelessWidget {
  final UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_renderBackground(context), _renderForm(context)],
      ),
    );
  }

  Widget _renderBackground(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final Widget _background = Container(
      height: _screenSize.height * .45,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 153, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );
    final Widget _circle = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    final Widget _avatar = Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 70,
          ),
          Text('Register',
              style: TextStyle(color: Colors.white, fontSize: 30.0))
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        _background,
        Positioned(
          top: 90.0,
          left: _screenSize.width * .30,
          child: _circle,
        ),
        Positioned(
          top: 50.0,
          left: _screenSize.width * .70,
          child: _circle,
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          child: _circle,
        ),
        SafeArea(
          child: _avatar,
        )
      ],
    );
  }

  Widget _renderForm(BuildContext context) {
    final bloc = Provider.of(context);
    final _screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: _screenSize.height * .30,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            width: _screenSize.width * .85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black12, offset: Offset(0.0, 5.0))
                ]),
            child: Column(
              children: <Widget>[
                Text('input'),
                _emailInput(bloc),
                _passwordInput(bloc),
                SizedBox(
                  height: 20.0,
                ),
                registerButton(context),
                _submit(bloc),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _emailInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'example@gmail.com',
              labelText: 'Email',
              counterText: asyncSnapshot.data,
              errorText: asyncSnapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _passwordInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.deepPurple,
              ),
              hintText: '*********',
              labelText: 'Password',
              counterText: asyncSnapshot.data,
              errorText: asyncSnapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _submit(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot<bool> asyncsnapshot) {
        return RaisedButton(
            child: Container(
              child: Text('Submit'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.deepPurple,
            textColor: Colors.white,
            elevation: 5.0,
            onPressed:
                asyncsnapshot.hasData ? () => _register(bloc, context) : null);
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) {
    userProvider.add(bloc.email, bloc.password);

    /*    if (bloc.email != null && bloc.password != null) {
      Navigator.of(context).pushNamed('/');
    } */
  }

/*   Widget _forgotButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(vertical: 0),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Text('forgot password?'),
        textColor: Colors.deepPurpleAccent,
        onPressed: () {},
      ),
    );
  } */

  Widget registerButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        margin: EdgeInsets.symmetric(vertical: 0),
        child: MaterialButton(
          height: 10,
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Text('login'),
          textColor: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.of(context).pushNamed('login');
          },
        ));
  }
}
