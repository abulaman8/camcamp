import 'package:flutter/material.dart';
import 'vplay.dart';

class CamList extends StatefulWidget {
  final List cameras ;
   const CamList({super.key, required this.cameras});

  @override
  State<CamList> createState() => _CamListState();
}

class _CamListState extends State<CamList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Camera List'),
      ),
      body: ListView.builder(
        itemCount: widget.cameras.length, 
        itemBuilder: (BuildContext context, int index) {
           return ListTile(
             title: Text(widget.cameras[index]['cam_id']),
             trailing: const Icon(Icons.videocam),
             subtitle: Text('${widget.cameras[index]["latitude"]}, ${widget.cameras[index]["longitude"]}'),
             onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => vPlayer(url: widget.cameras[index]['liveurl']),
                        ),
           ));
        },
      )
    );
  }
}