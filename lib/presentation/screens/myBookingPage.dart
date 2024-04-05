import 'package:flutter/material.dart';
import 'package:gigimu/presentation/provider/myBookingProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../domain/usecases/pasienUsecases.dart';


class MyBookingPage extends StatelessWidget {
  const MyBookingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Provider.of<MyBookingProvider>(context, listen: false).getMyBooks();

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Gw'),
      ),
      body: Consumer<MyBookingProvider>(
        builder: (context, provider, child){
          return Container(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: List.generate(provider.myBooks.length, (i) {
                return
                  GestureDetector(
                    onTap: (){
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.listDokter[i].nama)));
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
                                      provider.myBooks[i].dokter!.nama,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      )),
                                  Text(
                                      provider.myBooks[i].dokter!.spesialis,
                                      style: TextStyle(
                                          fontSize: 10
                                      )),
                                  Text(
                                      DateFormat('yyyy-MM-dd').format(provider.myBooks[i].jadwal!.tanggal as DateTime),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                  // You can load the user's photo here if available
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 1, 1),
                                  icon: Icon(
                                      Icons.delete,
                                      size: 40,
                                      color: Colors.white
                                  ), // Specify the icon
                                  onPressed: () async{
                                    await PasienUseCases().deleteBooking(provider.myBooks[i].bookingId.toString());
                                    Provider.of<MyBookingProvider>(context, listen: false).getMyBooks();
                                    context.go('/');
                                  },
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
