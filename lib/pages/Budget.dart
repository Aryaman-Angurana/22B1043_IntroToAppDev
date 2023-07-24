import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_items_class.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<dynamic> items = [];

List<dynamic> price = [];

class _HomeState extends State<Home> {
  void set() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamProvider<List<FUser>>.value(
      value: DatabaseService().budget,
      initialData: [],
      child: Scaffold(
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
              child: 
                  Categories(),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: items
                  //       .map((e) => Card_items(e, () {
                  //             setState(() {
                  //               items.remove(e);
                  //               total = total - int.parse(e[1]);
                  //             });
                  //           }))
                  //       .toList(),
                  // ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
      ),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<List<FUser>>(context);
    FUser f = FUser(uid: '0');

    for (int i = 0; i < b.length; i++) {
      print(b[i].uid);
      if (b[i].uid == 'budget/' + AuthService().getUid()) {
        f = b[i];
        print(f.items);
        print(f.price);
        print(f.uid);
        break;
      }
    }


      if (f.price != null && f.price!.isNotEmpty){
      items = f.items!;
      price = f.price!;
      total = 0;
      for (int i in price) {
        total += i;
      }

      List<List<dynamic>> budget = [];
      for (int i = 0; i < f.items!.length; i++) {
        budget += [
          [f.items![i], f.price![i]]
        ];
      }
      return Column(
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
                    items.remove(e[0]);
                    price.remove(e[1]);
                    total -= e[1];
                    DatabaseService(uid: AuthService().getUid())
                        .updateUserData(items, price);
                  });
                }))
            .toList(),
      ),
                ]
      );
    }
    else{
      return Container();
    }
  }
}
