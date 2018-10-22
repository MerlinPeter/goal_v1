import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'auth.dart';
import 'homePage.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;
  @override
    State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

 AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState(){
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }
  
  void signedOut(){
      setState(() {
        _authStatus = AuthStatus.notSignedIn;
      });
  }

  @override
  Widget build(BuildContext context){

    switch (_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(auth:widget.auth,
          onSignedIn: signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut :signedOut
        );
    }
  }
 }