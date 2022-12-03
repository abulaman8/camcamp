

import 'package:camcamp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:camcamp/utils/fns.dart';
import 'login.dart';
import 'camList.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Position? _position;
  double _lat = 12.99415605;
  double _lng = 80.2366825512945;
  bool? _isMock;
  bool _isLoggedin = true;
  FlutterSecureStorage _storage = const FlutterSecureStorage();
  




  Future _init()async{
    
    String? access = await _storage.read(key: 'access');
    String? refresh = await _storage.read(key: 'refresh');
    if(refresh == null || JwtDecoder.isExpired(refresh)==true){
      setState(() {
        _isLoggedin = false;
        print(_isLoggedin);

      });
    }
    else if(JwtDecoder.isExpired(refresh)==false){
      Map status = await refreshToken(refresh);
      if(status['status'] == false){
       setState(() {
        _isLoggedin = false;
        print(_isLoggedin);
      }); 
      }


    }
  }

  late final Future _logincheck = _init();

  @override
  void initState(){
    _getLoc();
    
    super.initState();
  }





  Future _getLoc() async{
    var location = loc.Location();
    var status = await Permission.location.status;
    if(status.isDenied){
      await Permission.location.request();
    }
    else if(status.isPermanentlyDenied){
      openAppSettings();
    }
    else if(status.isGranted){
      if(await Permission.location.serviceStatus.isEnabled){
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
        if(!position.isMocked){
          setState(() {
            _isMock = false;
          _position = position;
          _lat = position.latitude;
          _lng = position.longitude;

        });
        }
        else{
          setState(() {
            _isMock = true;

          _position = position;
          _lat = position.latitude;
          _lng = position.longitude;

        });
        }
        
      }
      else{
        location.requestService();
      }

    }
  }

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: _logincheck,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator(
          color: Constants.maroon,
          
          ),)
          );
      }
      return _isLoggedin ? Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () async{ 
            await _storage.deleteAll();
            Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Login()));

           },)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: FlutterMap(
                  options: MapOptions(
                    screenSize: Size(100, 150),
                    zoom: 15, 
                    center: LatLng(12.99415605,80.2366825512945)
                    ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://api.mapbox.com/styles/v1/abulaman/clb63m3qx000s14nx615hn714/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWJ1bGFtYW4iLCJhIjoiY2wzMzh1d25wMGlyNzNrcDV5NGpkNHQ5OSJ9.vWp-v0UIFzwp77pDMMoKSQ',
                      additionalOptions: const {
                        'accessToken': 'pk.eyJ1IjoiYWJ1bGFtYW4iLCJhIjoiY2wzMzh1d25wMGlyNzNrcDV5NGpkNHQ5OSJ9.vWp-v0UIFzwp77pDMMoKSQ',
                        'id': 'mapbox.mapbox-streets-v8'
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          
                          point: LatLng(_lat, _lng),
                          width: 80,
                          height: 80,
                          builder: ((context) => const Icon(
                            Icons.location_on,
                            color: Constants.red,
                            size: 50,
                            
                            )))
                      ],
                    )
                  ],
                  ),
              ),
            ),
            Container(
              height: 50,
              width: 290,

              child: ElevatedButton(
                
                onPressed: ()async{

                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const CamList()));

                  
                },
                child: const Text('Get Cameras around me'),
              ),
            )
          ],
          )
      ),
    ) : const Login();
  }
  );
  }
  }