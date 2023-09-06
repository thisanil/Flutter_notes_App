



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/see_space.dart';

class CuredOpration extends StatefulWidget {
  const CuredOpration({super.key});

  @override
  State<CuredOpration> createState() => _CuredOprationState();
}

class _CuredOprationState extends State<CuredOpration> {
  TextEditingController _controller=TextEditingController();
  TextEditingController _controller1=TextEditingController();
  final CollectionReference _table = FirebaseFirestore.instance.collection("Notes");

  create() async{
    await showModalBottomSheet(context: context, builder: (BuildContext context){
      return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,
            bottom:MediaQuery.of(context).viewInsets.bottom
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Tittle',labelText: 'Tittle'),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _controller1,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Summery',labelText: 'Summery'),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade50,
                  ),
                  onPressed: (){

                   String? tittle=_controller.text;
                   String? summery=_controller1.text;
                   _table.add({'Tittle':tittle,'Summery':summery});
                   _controller.text="";
                   _controller1.text="";
                  }, child: Text('ADD',style: TextStyle(color: Colors.black87),))
            ],
          ),
        ),
      );
    },);

  }
  update(String docId,String title,String summery) async{
         _controller.text=title;
         _controller1.text=summery;

    await showModalBottomSheet( isScrollControlled:true,
      context: context, builder: (BuildContext context){
      return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,
            bottom:MediaQuery.of(context).viewInsets.bottom
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Tittle',labelText: 'Tittle'),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _controller1,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: 'Summery',labelText: 'Summery'),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade50,
                  ),
                  onPressed: (){

                    String? tittle=_controller.text;
                    String? summery=_controller1.text;
                    _table.doc(docId).update({'Tittle':tittle,'Summery':summery});
                    _controller.text="";
                    _controller1.text="";
                  }, child: Text('ADD',style: TextStyle(color: Colors.black87),))
            ],
          ),
        ),
      );
    },);

  }

  delete(String DocId) async {
    await _table.doc(DocId).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        toolbarHeight: 50,
        title: Text("My Notes",style: TextStyle(color: Colors.black),),
        backgroundColor:Colors.green.shade50,
        elevation: 10,
      ),
      backgroundColor: Colors.white,
      body:StreamBuilder(
        stream: _table.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(

                itemCount:streamSnapshot.data!.docs.length,
                itemBuilder:(context,index){
                  var userData=streamSnapshot.data!.docs[index];
                  String Sum =userData['Summery'];
                  bool SumSize=false;
                  if(Sum.length>=24)
                    {
                     Sum =Sum.substring(0,23);
                     SumSize=true;
                    }
                  else{
                    Sum =userData['Summery'];
                  }
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15,),
                  child: InkWell(
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      color: Colors.green.shade50,
                      child: ListTile(
                        title: Text(userData['Tittle']),
                        subtitle: SumSize?Text("${Sum}......"):Text(Sum),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: (){
                                update(userData.id,userData['Tittle'],userData['Summery']);
                              }, icon: Icon(Icons.edit)),
                              IconButton(onPressed: (){
                                delete(userData.id);
                              }, icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SeeSpace(title:userData['Tittle'], summery:userData['Summery'],DocsId: userData.id,)));
                    },
                  ),
                );


                } );
              }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green.shade300,
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade50,
        onPressed:create,
        label: Text('ADD',style: TextStyle(color: Colors.black87),),
        // child: Text('ADD ',style: TextStyle(color: Colors.black87),),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
