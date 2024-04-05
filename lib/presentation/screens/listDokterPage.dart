import 'package:flutter/material.dart';
import 'package:gigimu/data/models/userModel.dart';
import 'package:gigimu/domain/usecases/pasienUsecases.dart';
import 'package:gigimu/presentation/components/myDetailRow.dart';
import 'package:gigimu/presentation/provider/listDokterProvider.dart';
import 'package:gigimu/presentation/screens/jadwalDokter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../data/models/dokterModel.dart';

class ListDokterPage extends StatelessWidget {
  const ListDokterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ListDokterProvider>(context, listen: false).getDokters();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Dokter'),
      ),
      body: Consumer<ListDokterProvider>(
        builder: (context, provider, child){
          return Container(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: List.generate(provider.listDokter.length, (i) {
                return
                  GestureDetector(
                    onTap: (){
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.listDokter[i].nama)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> JadwalDokterPage(dokterID: provider.listDokter[i].dokterId.toString())
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      provider.listDokter[i].nama,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30
                                  )),
                                  Text(
                                      provider.listDokter[i].spesialis,
                                      style: TextStyle(
                                        fontSize: 10
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                height: 100,
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
                          ],
                        ),
                      ),
                    ),
                  );
              }),
            ),
          );
        },
      ),
    );
  }
}
