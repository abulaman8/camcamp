


import 'package:camcamp/page/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';
import 'register.dart';
import 'package:camcamp/utils/fns.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
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
              'Welcome Back',
              style: GoogleFonts.bebasNeue(
                fontSize: 48,
                color: Constants.cream
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
                    Map r = await login(usernameController.text, passwordController.text );
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
                              style: TextStyle(
                                color: Colors.white
                              ),
                              ),
                            ),
                        )
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if(r['status'] == true){
                       Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage(),
                        ));
                    }
                  },
                  child: const Text('Login'),
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
                  const Text('Not Registered yet?',
                  style: TextStyle(
                    color: Colors.blue,
                    
                  ),
                  ),
                  TextButton(
                    onPressed:  () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Register(),
                          ),
                        ),
                    child: const Text(
                      'Register',
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