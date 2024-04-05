
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigimu/presentation/components/routerConfig.dart';
import 'package:gigimu/presentation/provider/jadwalDokterProvider.dart';
import 'package:gigimu/presentation/provider/listDokterProvider.dart';
import 'package:gigimu/presentation/provider/myBookingProvider.dart';
import 'package:gigimu/presentation/provider/myProfileProvider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if
  (!kIsWeb){
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }
  await Hive.openBox('userData');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListDokterProvider()),
        ChangeNotifierProvider(create: (context) => MyBookingProvider()),
        ChangeNotifierProvider(create: (context) => MyProfileProvider()),
        ChangeNotifierProvider(create: (context) => JadwalDokterProvider())
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routerConfig: RouterNavigation().getRoute(),
      debugShowCheckedModeBanner: false,
      // home: LoginPage()
    );
  }
}

