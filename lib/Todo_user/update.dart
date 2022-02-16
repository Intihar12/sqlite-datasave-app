import 'package:flutter/material.dart';
import 'package:sqflite_app/Todo_user/creatdatabase.dart';

import 'modal/modal.dart';

class updateData extends StatefulWidget {
  const updateData({Key? key, required this.name, required this.email, required this.password}) : super(key: key);
final String name;
final String email;
final String password;
  @override
  _updateDataState createState() => _updateDataState();
}

class _updateDataState extends State<updateData> {
SqlLiteData? handler;
  final namecontroller= TextEditingController();
  final emailcontroller= TextEditingController();
  final passwordcontroller= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = SqlLiteData();

    handler!.initializeDB().whenComplete(()async {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('update data'),),

      body: FutureBuilder(
        future: handler!.retriveuser(widget.name, widget.email, widget.password) ,
        builder: (BuildContext context, AsyncSnapshot <List<User>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder:( BuildContext context, int index ){
              return ListTile(
                key: ValueKey<int>(snapshot.data![index].id!),
              title: Column(children: [
                Text(snapshot.data![index].name),
                Text(snapshot.data![index].email),
                Text(snapshot.data![index].password),


                Container(
                  child: Column(
                    children: [
                      TextField(
                        controller:  namecontroller,
                        decoration: InputDecoration(
                            hintText: snapshot.data![index].name,
                           // labelText:  snapshot.data![index].name
                        ),),
                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                           hintText: snapshot.data![index].email,
                           // labelText: snapshot.data![index].email,
                        ),),
                      TextField(
                        controller:  passwordcontroller,
                        decoration: InputDecoration(
                            hintText: snapshot.data![index].password,
                           // labelText: snapshot.data![index].password,

                        ),
                      ),

                      TextButton(onPressed: (){
/*Navigator.push(context, MaterialPageRoute(builder: (context)=>showdata(
  name: namecontroller.text,email:  emailcontroller.text,password:  passwordcontroller.text,)));*/
setState(() {
  handler!.updatedata(
      namecontroller.text, emailcontroller.text, passwordcontroller.text, snapshot.data![index].id!);

}); //Navigator.of(context).pop();


                      },

                          child: Text('update'))
                    ],
                  ),
                ),

              ],),
              );

            });

          }
          return Center(child:  CircularProgressIndicator(),);
        } ,

      ),
    );
  }
}

