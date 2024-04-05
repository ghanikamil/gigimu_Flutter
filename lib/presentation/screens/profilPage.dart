import 'package:flutter/material.dart';
import 'package:gigimu/data/models/userModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:gigimu/presentation/components/myDetailRow.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<UserModel>(
        future: PasienUseCases().getUserDataById(box.get('id')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var user = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [

                Card(
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              // You can load the user's photo here if available
                            ),
                            child: Icon(
                              Icons.account_circle,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        MyDetailRow(label: "User ID", value: user.pasienId.toString()),
                        MyDetailRow(label: "Email  ", value: user.email),
                        MyDetailRow(label: "Name  ", value: user.nama),
                        MyDetailRow(label: "Telepon", value: user.telepon),
                        MyDetailRow(label: "Alamat ", value: user.alamat),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 300,),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                        bool status = await PasienUseCases().postUserLogout();
                        if(status){
                          context.go('/login');
                        }
                    },
                    child: Text("Logout"),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
