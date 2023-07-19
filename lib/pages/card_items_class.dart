import 'package:flutter/material.dart';
import 'budget_class.dart';

class Card_items extends StatelessWidget {
  final BudgetClass b;
  final void Function() delete;
  Card_items(this.b, this.delete);

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
              width: width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      b.name,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
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
                      '${b.money}',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          color: Colors.greenAccent,
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
