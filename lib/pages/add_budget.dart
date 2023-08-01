import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/card_items_class.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'Budget.dart';
import 'dart:math';

class Add extends StatefulWidget {
  Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final Controller1 = TextEditingController();
  final Controller2 = TextEditingController();
  final Controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Controller1.text = map['a'];
    Controller2.text = '${map['b']}';
    Controller3.text = map['c'];
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Categories',
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leading: CircleAvatar(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_outlined,
                ),
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            )),
        body: Stack(children: [
          Container(
            width: width,
            height: height,
            color: Colors.grey[800],
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
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
                            width: 80.0,
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
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                        budget.map((e) => Card_items(e, () {}, () {})).toList(),
                  ),
                ]),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Category",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            if (Controller1.text != "" &&
                                Controller2.text != "" &&
                                double.tryParse(Controller2.text) != null) {
                              int num = 10000000 + Random().nextInt(10000000);
                              items = items + [Controller1.text + '$num'];
                              price = price +
                                  [int.parse(Controller2.text + '$num')];
                              date = date + [Controller3.text + '$num'];
                              DatabaseService(uid: AuthService().getUid())
                                  .updateUserData(items, price, date);
                              total = total + int.parse(Controller2.text);
                            }
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  TextFormField(
                      controller: Controller1,
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      )),
                  TextFormField(
                    controller: Controller2,
                    decoration: InputDecoration(
                      labelText: "Price",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: Controller3,
                    decoration: InputDecoration(
                      labelText: "Date",
                      helperText: 'YYYY-MM-DD',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (Controller1.text != "" &&
                          Controller2.text != "" &&
                          double.tryParse(Controller2.text) != null) {
                        int num = 10000000 + Random().nextInt(10000000);
                        items = items + [Controller1.text + '$num'];
                        price = price + [int.parse(Controller2.text + '$num')];
                        date = date + [Controller3.text + '$num'];
                        DatabaseService(uid: AuthService().getUid())
                            .updateUserData(items, price, date);
                        total = total + int.parse(Controller2.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(Icons.check),
                    backgroundColor: Colors.black,
                  )
                ],
              ),
              width: width * 0.8,
              height: width,
            ),
          )
        ]));
  }
}
