import 'package:flutter/material.dart';
// import 'budget_class.dart';


bool isDisabled = false;

class Card_items extends StatelessWidget {
  final List<dynamic> b;
  final void Function() delete;
  final void Function() edit;
  Card_items(this.b, this.delete, this.edit);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: width * 0.65,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                          b[2].substring(0,b[2].length - 8),
                          style: TextStyle(
                            fontSize: 10.0,
                          ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          b[0].substring(0,b[0].length - 8),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          softWrap: false,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          '${(b[1]/100000000).floor()}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          color: Colors.white,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
                edit();
            },
            color: Colors.black,
            
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              delete();
            },
            color: Colors.black,
            
          ),
        ),
      ],
    );
  }
}
