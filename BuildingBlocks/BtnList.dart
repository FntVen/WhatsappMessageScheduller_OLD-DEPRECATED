import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/BuildingBlocks/SubMenus/ModifyAgen.dart';
import 'package:untitled/DataDump/EssencialData.dart';

class BtnListClients extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container
      (
        padding: EdgeInsetsGeometry.all(20),
        decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(10)),
        width: 2000,
        height: double.infinity,
        child: ValueListenableBuilder
          (
            valueListenable: AgenNomes,
            builder: (context,list,_)
            {
              return ListView.builder
                (
                  itemCount: Id.value.length,//Make a variable // Will determine the ammount of boxes
                  itemBuilder: (context, ContainerIndex)
                  {
                    return Padding
                      (
                        padding: EdgeInsetsGeometry.all(7),
                        child: Row
                          (
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Expanded
                                (
                                  child: Container
                                    (
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                      child: Text
                                        (
                                        "Cliente ${AgenNomes.value[ContainerIndex]} | ${AgenDataDeContato.value[ContainerIndex]} | Mensagem: ${EstagioAtualDeMensagens.value[ContainerIndex]}",textScaler: TextScaler.linear(1.7), style: TextStyle(color: Colors.white70, height: 2.5,),textAlign: TextAlign.center,
                                      )
                                  ),
                                ),
                              FloatingActionButton.small
                                (
                                onPressed: ()
                                {
                                  CleanTemps();
                                  Instance = ContainerIndex;
                                  ModifyStartup();
                                  AgenRepeatController.text = "${AgenRepeat.value[Instance]}";
                                  showDialog
                                    (
                                    context: context,
                                    builder: (context) =>
                                        Dialog
                                          (
                                            constraints: BoxConstraints
                                              (
                                                maxWidth: 600,
                                                maxHeight: 800,
                                                minHeight: 500,
                                                minWidth: 500
                                            ),
                                            child:ModifyWidget()
                                        ),
                                    );
                                },
                                splashColor: Colors.white,
                                backgroundColor: Colors.white10,
                                child: Icon(Icons.add,color: Colors.greenAccent,),
                              )
                            ],
                          )
                    );
                  }
              );
            }
          )
      );
  }

}

