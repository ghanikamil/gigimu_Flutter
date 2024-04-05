import 'package:flutter/material.dart';
import 'package:gigimu/data/models/addBookingRequestModel.dart';
import 'package:gigimu/presentation/provider/jadwalDokterProvider.dart';
import 'package:gigimu/presentation/screens/bottomNavbar.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../domain/usecases/pasienUsecases.dart';



class JadwalDokterPage extends StatelessWidget {
  final String dokterID;
  const JadwalDokterPage({Key? key, required this.dokterID});

  @override
  Widget build(BuildContext context) {
    Provider.of<JadwalDokterProvider>(context, listen: false).getJadwals(dokterID);
    var box = Hive.box('userData');

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Jadwalmu'),
      ),
      body: Consumer<JadwalDokterProvider>(
        builder: (context1, provider, child){
          return Container(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: List.generate(provider.listJadwal.length, (i) {
                return
                  Container(
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
                                    provider.listJadwal[i].status,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30
                                    )),
                                Text(
                                    DateFormat('yyyy-MM-dd').format(provider.listJadwal[i].tanggal as DateTime),
                                    style: TextStyle(
                                        fontSize: 10
                                    )),
                                Row(
                                  children: [
                                    Text(
                                      'jumlah saat ini :',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      provider.listJadwal[i].pasienTerdaftar.toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (provider.listJadwal[i].status == "Kosong")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                // You can load the user's photo here if available
                              ),
                              child: IconButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 1, 1),
                                icon: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.white
                                ),
                                onPressed: () async {
                                  AddBookingRequestModel data = AddBookingRequestModel(
                                    jadwalDokterId: provider.listJadwal[i].jadwalDokterId,
                                    pasienId: int.parse(box.get('id').toString()),
                                    jamBooking: DateTime.now()
                                  );
                                  bool status = await PasienUseCases().addBooking(data);
                                  if(status){
                                    context.go('/');
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
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
