import 'package:bkn_cashbook_mertha/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pengeluaran_Page extends StatefulWidget {
  Pengeluaran_Page({Key? key}) : super(key: key);

  @override
  State<Pengeluaran_Page> createState() => _ExpenditurePageState();
}

class _ExpenditurePageState extends State<Pengeluaran_Page> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final DbHelper dbHelper = DbHelper();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void resetForm() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    amountController.clear();
    descriptionController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              "TAMBAH PENGELUARAN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: dateController,
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: InputDecoration(
              labelText: "Tanggal:",
              labelStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Nominal: Rp ",
              labelStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
            // create style use color deeppurple
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: "Keterangan:",
              labelStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
          SizedBox(height: 60),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromARGB(255, 113, 206, 206)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)))),
                  onPressed: () {
                    resetForm();
                  },
                  child: const Text("Reset"),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(186, 48, 145, 236)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)))),
                  onPressed: () async {
                    String date = dateController.text;
                    String amount = amountController.text;
                    String description = descriptionController.text;

                    if (date.isNotEmpty && amount.isNotEmpty) {
                      int rowCount = await dbHelper.insertExpense(
                          date, amount, description);
                      if (rowCount > 0) {
                        // Successfully added income data
                        resetForm(); // Reset the form
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Pengeluaran berhasil disimpan."),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Gagal menyimpan pemasukan."),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Tanggal dan Jumlah harus diisi."),
                        ),
                      );
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
              Container(
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
          )
        ],
      ),
    ));
  }
}
