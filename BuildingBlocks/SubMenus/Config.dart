import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Control/CsvControl.dart';
import 'package:untitled/DataDump/EssencialData.dart';

class ConfigWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container
      (
      decoration: BoxDecoration(color: Colors.black87,
      borderRadius: BorderRadius.circular(25)),
      child: Padding
        (
          padding: EdgeInsetsGeometry.all(20),
          child: Column
            (
            mainAxisSize: MainAxisSize.min,
            children:
            [
              Expanded //Campo 1
                (
                  flex: 1,
                  child: Container
                    (
                    alignment: Alignment.center,
                    margin: EdgeInsetsGeometry.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                    child: TextFormField
                      (
                      onChanged: (PhoneNumber)
                      {
                        if(PhoneNumber.length >= 11)
                        {
                          NumeroQueDispara.value = int.parse(PhoneNumber);
                        }
                      },
                      initialValue: "${NumeroQueDispara.value}",
                      maxLength: 11,
                      decoration: InputDecoration
                        (
                          contentPadding: EdgeInsetsGeometry.all(10),
                          label: Text("Número usado para disparos", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                          border: InputBorder.none,
                        ),
                        inputFormatters:
                        [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      )
                  )
                ),
              Expanded //Campo 2
                (
                  flex: 1,
                  child: Container
                    (
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                    alignment: Alignment.center,
                    margin: EdgeInsetsGeometry.all(10),
                      child: TextFormField
                        (
                        onChanged: (IAName)
                        {
                          NomeQueDispara.value = IAName;
                        },
                        initialValue: "${NomeQueDispara.value}",
                        maxLength: 100,
                        decoration: InputDecoration
                          (
                          contentPadding: EdgeInsetsGeometry.all(10),
                          label: Text("Nome usado pelo BOT/IA", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                            border: InputBorder.none
                        ),
                      )
                  )
              ),
              Padding
                (
                  padding: EdgeInsetsGeometry.all(1),
                  child: FloatingActionButton
                    (
                    splashColor: Colors.white,
                    backgroundColor: Colors.white10,
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.check_box_rounded,color: Colors.greenAccent,),
                  ),
                )
            ],
            )
        ),
    );
  }
}