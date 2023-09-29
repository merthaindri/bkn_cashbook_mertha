import 'package:bkn_cashbook_mertha/constant/route_constants.dart';
import 'package:bkn_cashbook_mertha/helper/dbhelper.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Center(
            child: Column(
          children: [
            Text(
              "RANGKUMAN BULAN INI",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Total Pemasukan: \Rp $totalIncome",
                style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 53, 172, 57),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Total Pengeluaran: \Rp $totalExpense",
                style: TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/grafik1.png',
                      width: 500,
                      height: 300,
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/pemasukan.jpg',
                        label: "Tambah Pemasukan",
                        onTap: () {
                          Navigator.pushNamed(context, pemasukanRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/pengeluaran.jpg',
                        label: "Tambah Pengeluaran",
                        onTap: () {
                          Navigator.pushNamed(context, pengeluaranRoute);
                        }),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/cash flow.png',
                        label: "Detail Cash Flow",
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/setting.png',
                        label: "Pengaturan",
                        onTap: () {
                          Navigator.pushNamed(context, settingRoute);
                        }),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
