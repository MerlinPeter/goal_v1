import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget{

 LoginPage({this.auth, this.onSignedIn});
 final BaseAuth auth;
 final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

enum FormType{
  login,
  register
}
class _LoginPageState extends State<LoginPage> {
  final formKey  = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
  final form = formKey.currentState;
    if (form.validate()) {
      form.save();
       print('Form is valid. Email $_email, password: $_password');
       return true;
     } 
     return false;
  }

  void validateAndSubmit() async{
    if (validateAndSave()){
             print('Form is valid. Email $_email, password: $_password');

      try {
         if  (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed User: $userId' );
         }else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Signed User: $userId' );
        }
        widget.onSignedIn();
      } catch (e) {
        print( e);
      }

    }
  }

 void moveToRegister() {
  formKey.currentState.reset();
   setState((){
      _formType = FormType.register;
   });
  }

   void moveToLogin() {
   formKey.currentState.reset();
   setState((){
      _formType = FormType.login;
   });
  }

  @override
  Widget build(BuildContext context){

     return new Scaffold(
       appBar:new AppBar(
         title:new Text('login'),
       ),
       body: new Container(
         padding: EdgeInsets.all(16.0),
         child : new Form(
            key: formKey,
           child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: 
                buildUIInput() + buildUIButton() ,
            
           ),

         ),
       ),
     );
  }

  List <Widget> buildUIButton(){
    if ( _formType == FormType.login ){
      return[
        new RaisedButton(
            child : new Text('Login', style: new TextStyle(fontSize :20.0)),
            onPressed: validateAndSubmit,

          ),
        new FlatButton(
            child : new Text('Register', style: new TextStyle(fontSize :20.0)),
            onPressed: moveToRegister,
          )
        ];
    }else{
      return [
        new RaisedButton(
            child : new Text('Create an account', style: new TextStyle(fontSize :20.0)),
            onPressed: validateAndSubmit,

          ),
         new FlatButton(
            child : new Text('Have an account ? Login', style: new TextStyle(fontSize :20.0)),
            onPressed: moveToLogin,
          )
          ];
    }
  }

  List<Widget> buildUIInput(){
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText :'Email'),
        validator : (value)=> value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value ,
      ),            
      new TextFormField(
        decoration: new InputDecoration(labelText :'Password'),
        obscureText: true,
        validator : (value) => value.isEmpty ? 'Password can\'t be empty' : null ,
        onSaved: (value) => _password = value ,
      ),
    ];
  }
}