import 'dart:convert' as convert;

import 'package:camcamp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'package:camcamp/utils/fns.dart';



class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



 





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.map_outlined,
              size: 100,
              color: Constants.beige,
              ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: Text(
              'Hello There',
              style: GoogleFonts.bebasNeue(
                fontSize: 48
              ),
              ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username...'
                ),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password...',
                  ),
                ),
            ),
          ),
          
          Container(
                height: 75,
                width: 310,
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: ElevatedButton(
                  onPressed: () async{
                    Map r = await register(usernameController.text, passwordController.text );
                    if(r['status'] == false){
                      var snackBar = SnackBar(
                        backgroundColor: Colors.red.shade400,
                        content: SizedBox (
                          height: 48,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.red.shade400
                              ),
                            child: Text(
                              '${r["message"]}',
                              style: const TextStyle(
                                color: Colors.white
                              ),
                              ),
                            ),
                        )
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if(r['status'] == true){
                      var snackBar = SnackBar(
                        backgroundColor: Colors.green.shade400,
                        content: SizedBox (
                          height: 48,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.green.shade400
                              ),
                            child: Text(
                              '${r["message"]}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                              ),
                            ),
                        )
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Register'),
                )
            ),
            Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a user?',
                  style: TextStyle(
                    color: Colors.blue,
                    
                  ),
                  ),
                  TextButton(
                    onPressed:  () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Login(),
                          ),
                        ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                    color: Colors.blue,
                    fontWeight:  FontWeight.bold
                    
                  ),
                      ),
                    )
                ],
              ), 
              )
             
            ),
          ),
            
        ]
        ),
    );
  }
}