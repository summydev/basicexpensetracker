import 'package:expensetracker/routes/routes.dart';
import 'package:expensetracker/views/addexpenseview.dart';
import 'package:expensetracker/views/expenselistview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ExpenseListView(),
      // initialRoute:RoutesClass.getHomeRoute() ,
   
    );
  }
}
