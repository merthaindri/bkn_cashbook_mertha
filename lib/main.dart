import 'package:bkn_cashbook_mertha/constant/route_constants.dart';
import 'package:bkn_cashbook_mertha/pages/pengeluaran_page.dart';
import 'package:bkn_cashbook_mertha/pages/pemasukan_page.dart';
import 'package:bkn_cashbook_mertha/pages/detailcf_page.dart';
import 'package:bkn_cashbook_mertha/pages/home_page.dart';
import 'package:bkn_cashbook_mertha/pages/login_page.dart';
import 'package:bkn_cashbook_mertha/pages/setting_page.dart';
import 'package:bkn_cashbook_mertha/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => Login_Page(),
  homeRoute: (BuildContext context) => Home_Page(),
  settingRoute: (BuildContext context) => Setting_Page(),
  pengeluaranRoute: (BuildContext context) => Pengeluaran_Page(),
  pemasukanRoute: (BuildContext context) => Pemasukan_Page(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlow_Page(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BKN CASHBOOK APP",
      theme: ThemeData(primaryColor: Colors.grey),
      routes: routes,
    );
  }
}
