import 'package:expensetracker/views/addexpenseview.dart';
import 'package:expensetracker/views/expenselistview.dart';
import 'package:get/get.dart';

class RoutesClass {
  static String home = "/";
  static String addTask = "/addTask";

  static String getHomeRoute() => home;
  static String getAddTaskRoute() => addTask;

  // static List<GetPage> routes = [
  //   GetPage(page: () => ExpenseListView(), name: home),
  //   GetPage(name: addTask, page: () => addTask)
  // ];

  List<GetPage> getPages = [
    GetPage(name: RoutesClass.home, page: () => ExpenseListView()),
  GetPage(name: RoutesClass.addTask, page: ()=> AddexpenxeView()),
  ];
}
