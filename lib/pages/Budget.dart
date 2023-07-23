import 'package:flutter/material.dart';
import 'budget_class.dart';
import 'card_items_class.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<BudgetClass> items = [
  BudgetClass('Groceries', -1400),
  BudgetClass('Bills', -1000),
  BudgetClass('Salary', 40000),
  BudgetClass('School fees', -10000)
];

class _HomeState extends State<Home> {
  void set() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Categories',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.grey[800],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
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
                          width: 20.0,
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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        isDisabled = true;
        Navigator.pushNamed(context, '/add_budget').then((value) {
          isDisabled = false;
          set();
        });
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      hoverColor: Colors.grey[400],
      ),
    );
  }
}
