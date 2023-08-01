// import 'package:budget_tracker/pages/budget_class.dart';
import 'package:budget_tracker/pages/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  FUser? _userFromFirebaseUser(User? user) {
    return user != null ? FUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<FUser?> get user {
    return _auth.authStateChanges()
      .map(( user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  String getUid()
  {
    return _auth.currentUser!.uid;
  }



  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;


      DatabaseService(uid: user!.uid).updateUserData(['Salary10000000'],[ 4000010000000], ['1-1-110000000']);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}




class FUser
{
  String? uid;
  List<dynamic>? items;
  List<dynamic>? price;
  List<dynamic>? date;
  FUser({required this.uid, this.items, this.price, this.date});
}