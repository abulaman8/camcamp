

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart';
import 'page/home.dart';

import 'page/login.dart';
import 'utils/constants.dart';
import 'utils/coreTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CoreTheme.dark(),
      home: const HomePage(),
    );
  }
}

// FutureBuilder(
//     future: _init(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         // Future hasn't finished yet, return a placeholder
//         return CircularProgressIndicator;
//       }
//       return _isLoggedin ? Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: ()async{
//                 await _getLoc();
//                 if(_isMock == true){
//                   var snackBar = SnackBar(
//                         content: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             color: Colors.red.shade400
//                             ),
//                           child: const Text(
//                             'GPS spoofer app detected, please stop any such app and try again.',
//                             style: TextStyle(
//                               color: Colors.white
//                             ),
//                             ),
//                           )
//                       );
//                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }
//                 else{
//                   Navigator.of(context).push(
//                       MaterialPageRoute<void>(
//                         builder: (BuildContext context) => const CamList()));
//                 }
//               },
//               child: const Text('Get Cameras around me'),
//             )
//           ],
//           )
//       ),
//     ) : const Login();
//   }
//     }
// )
      