import 'package:flutter/material.dart';

class HistoryContainer extends StatelessWidget {
   HistoryContainer({Key? key, required this.time,required this.imgUrl, required this.temp}) : super(key: key);
   String temp,imgUrl,time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 50,bottom: 50,right: 10),
      child: Container(
        width: 100,
        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(45)),
        child: Column(children: [
          Image(height: 100,width: 50,image: AssetImage(imgUrl)),
          Text(time.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(temp.toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ]),
      ),
    );
  }
}
