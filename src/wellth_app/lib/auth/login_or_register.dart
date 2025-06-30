/*import 'package:flutter/material.dart';
import 'package:wellth_app/pages/register_page.dart';
import 'package:wellth_app/pages/custom_login_page.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}




class _LoginOrRegisterState extends State<LoginOrRegister>{
  //initialy show login page
  bool showLoginPage = true;

  //create toggle method between login and register page
  void togglePages(){
    setState( (){
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build (BuildContext context){
    if (showLoginPage){
      return CustomLoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}
*/