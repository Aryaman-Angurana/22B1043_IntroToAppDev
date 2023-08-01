import 'package:budget_tracker/pages/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid });

  // collection reference
  final CollectionReference Data = FirebaseFirestore.instance.collection('budget');

  Future<void> updateUserData(List<dynamic> items, List<dynamic> price, List<dynamic> date) async {
    return await Data.doc(uid).set({
      'items' : items,
      'price' : price,
      'date' : date
    });
  }


  List<FUser> _budgetListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return FUser(
      uid: doc.reference.path,
      items: doc.get('items'),
      price: doc.get('price'),
      date: doc.get('date')
      );
    }).toList();
  }

  // get brews stream
  Stream<List<FUser>> get budget {
    return Data.snapshots()
      .map(_budgetListFromSnapshot);
  }


}