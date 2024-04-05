import 'package:flutter/material.dart';
import 'package:gigimu/data/models/loginModel.dart';
import 'package:gigimu/data/models/registerModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:gigimu/presentation/components/myTextField.dart';
import 'package:go_router/go_router.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //controller
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final rePasswordController = TextEditingController();

  //login method
  void login(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Center(
              child: Form(
                key: _loginForm,
                child: Column(
                  children: [
                    //logo
                    SizedBox(height: 20),
                    const Icon(
                      Icons.local_hospital_rounded,
                      color: Colors.lightBlueAccent,
                      size: 100,
                    ),

                    //welcome back
                    Text(
                      "Mari Rawat Gigimu",
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 25),
                    MyTextField(
                      controller: namaController,
                      hinText: "Nama",
                      obscureText: false,
                    ),
                    SizedBox(height: 10,),
                    MyTextField(
                      controller: alamatController,
                      hinText: "Alamat",
                      obscureText: false,
                    ),
                    SizedBox(height: 10,),
                    MyTextField(
                      controller: teleponController,
                      hinText: "Telepon",
                      obscureText: false,
                    ),
                    SizedBox(height: 10,),
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
                    MyTextField(
                      controller: rePasswordController,
                      hinText: "rePassword",
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
                              "udah punya akun? login aja",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            onPressed: (){
                              context.go('/login');
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
                                  RegisterModel registerData = RegisterModel(
                                    nama: namaController.text,
                                    alamat: alamatController.text,
                                    email: emailController.text,
                                    telepon: teleponController.text,
                                    password: passwordController.text,
                                    repassword: rePasswordController.text
                                  );
                                  bool status = await PasienUseCases().registerPasien(registerData);
                                  if (status){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text('Register Berhasil')));
                                    context.go('/login');
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text('Register gagal')));

                                  }
                                }
                              },
                              child: const Text(
                                "Register",
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
        ),
      ),
    );
  }
}
