import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:flutter/material.dart';
import 'card_items_class.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Map map = {'a': '', 'b': '', 'c': ''};

List<List<dynamic>> budget = [];

class _HomeState extends State<Home> {
  void set() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    budget = [];
    for (int i = 0; i < items.length; i++) {
      budget += [
        [items[i], price[i], date[i]]
      ];
    }





    int max = 0;
    for (int i = 0; i < budget.length; i++)
    {
      max = i;
      for (int j = i+1; j < budget.length; j++)
      {
        if (int.parse(budget[j][2].substring(0,4)) > int.parse(budget[max][2].substring(0,4)))
        {
          max = j;
        }
        else if (int.parse(budget[j][2].substring(0,4)) == int.parse(budget[max][2].substring(0,4)) && int.parse(budget[j][2].substring(5,7)) > int.parse(budget[max][2].substring(5,7)))
        {
          max = j;
        }
        else if (int.parse(budget[j][2].substring(5,7)) == int.parse(budget[max][2].substring(5,7)) && int.parse(budget[j][2].substring(8,10)) > int.parse(budget[max][2].substring(8,10)))
        {
          max = j;
        }
      }
      List a = budget[i];
      budget[i] = budget[max];
      budget[max] = a;
    }















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
                children: budget
                    .map((e) => Card_items(e, () {
                          setState(() {
                            map = {'a': '', 'b': '', 'c': ''};
                            items.remove(e[0]);
                            price.remove(e[1]);
                            date.remove(e[2]);
                            total -= (e[1] / 100000000).floor();
                            DatabaseService(uid: AuthService().getUid())
                                .updateUserData(items, price,date);
                          });
                        }, () {
                          setState(() {
                            map = {
                              'a': e[0].substring(0, e[0].length - 8),
                              'b': (e[1] / 100000000).floor(),
                              'c' : e[2].substring(0, e[2].length - 8)
                            };
                            items.remove(e[0]);
                            price.remove(e[1]);
                            date.remove(e[2]);
                            total -= (e[1] / 100000000).floor();
                            DatabaseService(uid: AuthService().getUid())
                                .updateUserData(items, price, date);
                            Navigator.pushNamed(context, '/add_budget')
                                .whenComplete(() => set());
                          });
                        }))
                    .toList(),
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          map = {'a': '', 'b': '', 'c': ''};
          Navigator.pushNamed(context, '/add_budget').then((value) {
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
