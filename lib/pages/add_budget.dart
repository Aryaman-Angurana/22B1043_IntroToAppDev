import 'package:budget_tracker/pages/budget_class.dart';
import 'package:flutter/material.dart';
import 'card_items_class.dart';
import 'home.dart';
import 'Budget.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final Controller1 = TextEditingController();
  final Controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Budget Tracker',
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.greenAccent,
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
                          Text(
                            '$total',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
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
                    children: items
                        .map((e) => Card_items(e, () {
                              setState(() {
                                items.remove(e);
                                total = total - e.money;
                              });
                            }))
                        .toList(),
                  ),
                ],
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                      controller: Controller1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      )),
                  Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: Controller2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  FloatingActionButton(onPressed: () {
                    items = items +
                        [
                          BudgetClass(
                              Controller1.text, int.parse(Controller2.text))
                        ];
                    total = total + int.parse(Controller2.text);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.check),)
                ],
              ),
              width: width * 0.8,
              height: width * 0.8,
            ),
          )
        ]));
  }
}
