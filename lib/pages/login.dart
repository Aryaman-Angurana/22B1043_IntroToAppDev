import 'package:budget_tracker/pages/authenticate.dart';
import 'package:budget_tracker/pages/loading.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {


  final Function toggleView;
  Login({required this.toggleView });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In to your account',
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Up'),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[700],
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,          
            children: [
              SizedBox(height: 20.0,),
              TextFormField(decoration: InputDecoration(labelText: "Email", fillColor: Colors.white, filled: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0))),
              onChanged: (value) => email = value,
              validator: (value) => value!.isEmpty ? "Enter the email" : null,
              ),
              SizedBox(height: 20.0,),
              TextFormField(decoration: InputDecoration( labelText: "Password", fillColor: Colors.white, filled: true, enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0))),
              onChanged: (value) => password = value,
              obscureText: true,
              validator: (value) => value!.length < 6 ? "Length of password should be atleast 6 characters" : null,
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)
                ),
                onPressed: () async {
                  if (_formkey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Invalid Credentials';
                      });
                    }
                }},
                child: Text("Sign in")
               ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      )
    );
  }
}