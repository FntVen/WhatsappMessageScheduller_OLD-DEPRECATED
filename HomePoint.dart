import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/BuildingBlocks/BtnList.dart';
import 'package:untitled/BuildingBlocks/SideOptionsHorizontalList.dart';
import 'package:untitled/Control/CsvControl.dart';

class home extends StatelessWidget
{
  const home({super.key});
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar
          (
            title: Text("Agendamento de Mensagens",
              style: TextStyle(color: Colors.white),
              textScaler: TextScaler.linear(0.8),),
              backgroundColor: Colors.greenAccent[400],

          ),
        floatingActionButton: FloatingActionButton
          (
            onPressed: ()
            {
              CsvReadBulk();
            },
            child: Icon(Icons.change_circle_rounded, color: Colors.greenAccent,),
            splashColor: Colors.white,
            backgroundColor: Colors.white10,
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: //To add more elements than the ListView you need to change the body directly, nothing else accepts children only child
        Padding
          (
            padding: EdgeInsetsGeometry.fromLTRB(60, 10, 60, 10),
            child: Column
            (
             mainAxisSize: MainAxisSize.max,
             children:
             [
               Flexible
               (
                 child:
                   HorizontalOptions(), //what it says on the tin
               ),
               Expanded
                 (
                   flex: 8,//This decides the size of the list... Holy fuck that took too long
                   child:
                   BtnListClients()//Client List

               )

             ],
            )
          ),
      backgroundColor: Colors.white24,
    );
  }
}