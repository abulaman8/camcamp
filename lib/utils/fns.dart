
import 'dart:convert' as convert;




import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



const BASE_URL = '20.244.37.41';


const _storage = FlutterSecureStorage();

Future login(String username, String password)async{
  var url =
      Uri.http(BASE_URL, '/student/token/');
       var response = await http.post(url, body: {
         "username": username,
         "password": password
       }
       );

       if(response.statusCode ==200){
         var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
         _storage.write(key: 'access', value: jsonResponse['access']);
         _storage.write(key: 'refresh', value: jsonResponse['refresh']);
          return {"status": true, "message":"success"};

       }
       else if(response.statusCode == 401){
         return {"status": false, "message":"Invalid Credentials"};
       }
       else{
         return {"status": false, "message":"Unable to reach server, check if your internet is on"};
       }

  }

Future refreshToken(String rtoken)async{
  var url = Uri.http(BASE_URL, '/student/token/refresh/');
  var response = await http.post(url, body: {
         "refresh": rtoken,
         
       });
       if(response.statusCode ==200){
         var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
         _storage.write(key: 'access', value: jsonResponse['access']);
         _storage.write(key: 'refresh', value: jsonResponse['refresh']);
          return {"status": true, "message":"success"};
       }
       else{
         return {"status": false, "message":"Invalid refresh token"};
       }
  
}

Future<List> getCameras(double latitude, double longitude)async{
  var url = Uri.http(BASE_URL, '/student/get-cameras/');
  String? access = await _storage.read(key: 'access');
  String? refresh = await _storage.read(key: 'refresh');
  if(refresh == null || JwtDecoder.isExpired(refresh) == true){
    return [{'status': false, 'message': 'missing/invalid refresh token'}];
  }
  else if(access == null || JwtDecoder.isExpired(access)){
    Map status = await refreshToken(refresh);
    if(status['status']){
      String? access = await _storage.read(key: 'access');
       var response = await http.post(
    url,
    headers: {
      "Authorization":"Bearer $access",
      'content-type': 'application/json'
    },
    body: convert.json.encode({
      "latitude": latitude,
      "longitude": longitude
    })
    );
     if(response.statusCode == 200){
    var jsonResponse =
        convert.jsonDecode(response.body) as List<Map>;
        jsonResponse.add({'status':true});
        return jsonResponse;
        }

    }
    else{
      return [{
        "status": false, 
        "message": "token refresh unsuccessfull"
      }];
    }
  }
  
  else{
    String? access = await _storage.read(key: 'access');
       var response = await http.post(
    url,
    headers: {
      "Authorization":"Bearer $access",
      'content-type': 'application/json'
    },
    body: convert.json.encode({
      "latitude": latitude,
      "longitude": longitude,
    }));
     if(response.statusCode == 200){
    var jsonResponse =
        convert.jsonDecode(response.body) as List;
        jsonResponse.add({'status':true});
        return jsonResponse;
        }
      else{
        return [{"staus":false, "message":"something went wrong"}];
      }
  }
  return [{"staus":false, "message":"something went wrong"}];

  
}



 Future<dynamic> register(String username, String password)async{
  var url =
      Uri.http(BASE_URL, '/student/register/');
       var response = await http.post(url, body: {
         "username": username,
         "password": password
       }
       );

       if(response.statusCode ==201){


          return {"status": true, "message":"User registered successfully"};

       }
       else if(response.statusCode == 403){
         return {"status": false, "message":"User with the username already exists"};
       }
       else if(response.statusCode == 400){
         return {"status": false, "message":"Bad request, check inputs"};
       }
       else{
         return {"status": false, "message":"Unable to reach server, check if your internet is on"};
       }

  }


