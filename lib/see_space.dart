
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/feature/cured_opration.dart';

class SeeSpace extends StatelessWidget {

  final String title;
  final String summery;
  final String DocsId;
   SeeSpace({Key?key, required this.title, required this.summery, required this.DocsId}): super(key: key);

  @override

  final CollectionReference _table = FirebaseFirestore.instance.collection("Notes");


  delete(String docId) async {
    await _table.doc(docId).delete();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         title: Text(title,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.green.shade50,
        toolbarHeight: 50,
        elevation: 10,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>CuredOpration()));
        },icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
            child: Text(summery,style: TextStyle(color: Colors.black54,fontSize: 16)),

          ),
          SizedBox(height: 40,),
          DefaultTabController(

               length: 1,
              child: TabBar(
                onTap: (index){

                      delete(DocsId);
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>CuredOpration()));
                },
                  indicatorColor: Colors.green.shade200,
                  tabs: [

                         Tab(
                           child:Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text('Delete',style: TextStyle(color: Colors.black),),
                               SizedBox(width: 10,),
                               Icon(Icons.delete,color: Colors.black45,),
                             ],
                           ),

                         ),
                        ]
               ),
               ),

                ]
             ),
            );
  }
}
