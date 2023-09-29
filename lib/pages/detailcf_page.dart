import 'dart:ui';

import 'package:bkn_cashbook_mertha/constant/finance_type_constants.dart';
import 'package:bkn_cashbook_mertha/helper/dbhelper.dart';
import 'package:bkn_cashbook_mertha/models/finance.dart';
import 'package:flutter/material.dart';

class DetailCashFlow_Page extends StatefulWidget {
  @override
  _DetailCashFlowPageState createState() => _DetailCashFlowPageState();
}

class _DetailCashFlowPageState extends State<DetailCashFlow_Page> {
  List<Finance> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database
    List<Finance> data = await dbHelper.getFinance();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database

    // Delete the item from the database
    await dbHelper.deleteDataFinance(cashFlowData[index].id!);

    // Remove the item from the list
    setState(() {
      cashFlowData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Text(
              "DETAIL CASH FLOW",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: cashFlowData.length,
            itemBuilder: (context, index) {
              final item = cashFlowData[index];
              final isIncome = item.type == incomeType;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  _deleteItem(index);
                },
                child: Icon(Icons.delete, color: Color.fromARGB(255, 24, 22, 22)),
              ),
              title: Text(
                    "${isIncome ? '( + )' : '( - )'}  Rp  ${item.amount}",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "${item.description}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(item.date!,
                  style: TextStyle(fontSize: 12),)
                ],
              ),
              trailing:  Icon(
                isIncome ? Icons.arrow_forward : Icons.arrow_back,
                color: isIncome ? Colors.green : Colors.red,
                size: 50,
              ),
            ),
          );
        },
      ),
    ),
          Container(
            margin: EdgeInsets.all(15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman Beranda
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)))),
                  child: const Text("<< Kembali"),
              ), 
          ),     
        ],
      ),
    );
  }
}
