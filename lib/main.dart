import 'package:flutter/material.dart';
import 'package:grocery/view/landing_screen.dart';
import 'package:provider/provider.dart';
import 'controller/provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProductProvider>.value(
        value: productProvider,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Store',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainLayout(),
    );
  }
}
