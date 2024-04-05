import 'package:flutter/material.dart';
import 'package:gigimu/data/models/loginModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:gigimu/presentation/components/myTextField.dart';
import 'package:go_router/go_router.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //controller
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  //login method
  void login(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _loginForm,
            child: Column(
              children: [
                //logo
                SizedBox(height: 50),
                const Icon(
                  Icons.local_hospital_rounded,
                  color: Colors.lightBlueAccent,
                  size: 100,
                ),
                SizedBox(height: 50),

                //welcome back
                Text(
                  "Mari Rawat Gigimu",
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 25),
                //email texfield
                MyTextField(
                  controller: emailController,
                  hinText: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 10,),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hinText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 10,),
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "belum punya akun? register dulu",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        onPressed: (){
                          context.go('/register');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),

                //sign button

                Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.black,
                            // foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                            onPressed: () async{
                              if(_loginForm.currentState!.validate()){
                                LoginModel loginData = LoginModel(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                bool status = await PasienUseCases().postUserLoginData(loginModel: loginData);
                                if(status){
                                  context.go('/');

                                }
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text('Login gagal')));
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),

                        ),
                      ),
                    ],
                  ),
                )

                //register
              ],
            ),
          ),
        ),
      ),
    );
  }
}
