import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    double height = MediaQuery.of(context).size.height;
    return StreamProvider<List<FUser>>.value(
      value: DatabaseService().budget,
      initialData: [],
      child: Scaffold(
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
                  child:
                      Categories()
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
                      keyboardType: TextInputType.number,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (Controller1.text != "" &&
                            Controller2.text != "" &&
                            double.tryParse(Controller2.text) != null) {
                          items = items + [Controller1.text];
                          price = price + [int.parse(Controller2.text)];
                          DatabaseService(uid: AuthService().getUid()).updateUserData(items, price);
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
                height: width * 0.8,
              ),
            )
          ])),
    );
  }
}
