import 'package:flutter/material.dart';
import 'package:viacep/database/app_database.dart';
import 'package:viacep/database/dao/cep_dao.dart';
import 'package:viacep/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('cep_database.db').build();

  runApp(MyApp(cepDao: database.cepDao));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.cepDao,
  });

  final CepDao cepDao;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio ViaCep Desafio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: Home(cepDao: cepDao),
    );
  }
}
