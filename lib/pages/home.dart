import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

num total = 0;
List<dynamic> items = [];

List<dynamic> price = [];

List<dynamic> date = [];


class _HomeScreenState extends State<HomeScreen> {

  final AuthService _auth = AuthService();

  void set() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {});
    return StreamProvider<List<FUser>>.value(
      value: DatabaseService().budget,
      initialData: [],
      child: Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: null,
        actions: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black)
              ),
              onPressed: () async {
                await _auth.signOut();
                items = [];
                price = [];
                date = [];
                total = 0;
                }
      ),]
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.grey[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_2_sharp,
              size: 200.0,
              color: Colors.white,
            ),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Total(),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.keyboard_double_arrow_down_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Budget')
                            .whenComplete(() => set());
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}


class Total extends StatefulWidget {
  const Total({super.key});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {

  @override
  Widget build(BuildContext context) {

    final b = Provider.of<List<FUser>>(context);
    FUser f = FUser(uid: '0');

    for (int i = 0; i < b.length; i++) {
      if (b[i].uid == 'budget/' + AuthService().getUid()) {
        f = b[i];

        break;
      }
    }if (f.price != null)
    {
      items = f.items!;
      price = f.price!;
      date = f.date!;
      total = 0;
      for (int i in price)
      {
        total += (i / 100000000).floor();
      }
      return Expanded(
                      child: Text(
                        '$total',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
    }
    return Expanded(child: Text(''));
  }
}