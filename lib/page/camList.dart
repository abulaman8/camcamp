import 'package:camcamp/page/home.dart';
import 'package:camcamp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vplay.dart';
import 'package:camcamp/utils/fns.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

class CamList extends StatefulWidget {


   const CamList({super.key});

  @override
  State<CamList> createState() => _CamListState();
}

class _CamListState extends State<CamList> {

  bool _hasData = false;
  String _message = '';
  List _cameras = [];
  Position? _position;
  double _lat = 12.99415605;
  double _lng = 80.2366825512945;
  bool? _isMock;
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




  Future<Map<String, dynamic>> getData()async{
    await _getLoc();
    if(_isMock==true){
      setState(() {
        _message  = 'GPS spoofer app detected, please stop any such app and try again.';
      });
      return {'status':false, 'message': 'GPS spoofer app detected, please stop any such app and try again.'};
      
    }
    List r = await getCameras(_lat,_lng);
    if(r[r.length-1]['status']){
      r.removeAt(r.length-1);
      _cameras = r;
      setState(() {
        _hasData = true;
      });
      return {'satus':true};

    }
    else{
      setState(() {
        _message = r[r.length-1]['message'];
      });
      return {'status':false, 'message': r[r.length-1]['message']};
    }
  }

  late final Future<Map<String, dynamic>> _dataCheck = getData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataCheck,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
        // Future hasn't finished yet, return a placeholder
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Retreiving Camera streams around you',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                      fontSize: 36,
                      color: Constants.cream
                    ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CircularProgressIndicator(
                color: Constants.maroon,
                
                ),
              ],
            ),
          )
          );
      }
      return _hasData ? Scaffold(
      appBar: AppBar(
        title: const Text('Camera List'),
      ),
      body: ListView.builder(
        itemCount: _cameras.length, 
        itemBuilder: (BuildContext context, int index) {
           return ListTile(
             title: Text(_cameras[index]['cam_id']),
             trailing: const Icon(Icons.videocam),
             subtitle: Text('${_cameras[index]["latitude"]}, ${_cameras[index]["longitude"]}'),
             onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => vPlayer(url: _cameras[index]['liveurl']),
                        ),
           ));
        },
      )
    ): Scaffold(
      appBar: AppBar(
        title: const Text('Camera List'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.warning_amber_rounded,
                size: 100,
                color: Constants.red,
                ),
            ),

              const SizedBox(
                height: 40,
              ),
      
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                _message,
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                fontSize: 36,
                color: Constants.red
                ),
                ),
            ),
          ],
        ),
      ),
    );
      },
    );
    
  }
}