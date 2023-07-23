import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int total = 0;

class _HomeScreenState extends State<HomeScreen> {
  void set() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: null,
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
                    Expanded(
                      child: Text(
                        '$total',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
    );
  }
}
