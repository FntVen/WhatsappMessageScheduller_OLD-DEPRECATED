import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/BuildingBlocks/SubMenus/Config.dart';
import 'package:untitled/BuildingBlocks/SubMenus/MakeNewClient.dart';
import 'package:untitled/Control/CsvControl.dart';
import 'package:untitled/DataDump/EssencialData.dart';
import 'SubMenus/MakeNew.dart';

class HorizontalOptions extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final list = AgenNomes.value;
    return Container
      (
        decoration: BoxDecoration
          (
            color: Colors.white12, borderRadius: BorderRadius.circular(20)
          ),
        padding: EdgeInsetsGeometry.fromLTRB(10, 7, 10, 7),
        width: 1200,
        height: 60,
        margin: EdgeInsetsGeometry.all(10),
        child:
        (
            Row
              (
              spacing: 10,
              children:
              [
                Expanded
                  (
                    flex: 2,
                    child: InkWell
                      (
                      onTap: ()
                      {
                        CleanTemps();
                        Startup();
                        ClearCreateValues();
                        SetMenuItems();
                        showDialog
                          (
                            context: context,
                            builder: (context) =>
                                Dialog
                                  (
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                                    constraints: BoxConstraints
                                      (
                                        maxWidth: 600,
                                        maxHeight: 910,
                                        minHeight: 210,
                                        minWidth: 500
                                    ),
                                    child: NewUserWidget()
                                )
                          );
                      }, //Ao Apertar
                      borderRadius: BorderRadius.circular(10),
                      child: Container
                        (
                        decoration: BoxDecoration(color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text
                          ("Criar Novo Agendamento",
                          style: TextStyle(
                              fontFamily: "Bricolage", color: Colors.white70),
                          textScaler: TextScaler.linear(1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ),
                Expanded
                  (
                    flex: 2,
                    child: InkWell
                      (
                      onTap: ()
                      {

                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container
                        (
                        decoration: BoxDecoration(color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text
                          (
                          " IA e Mensagens Automaticas",
                          style: TextStyle(
                              fontFamily: "Bricolage", color: Colors.white70),
                          textScaler: TextScaler.linear(1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ),
                Expanded
                  (
                    flex: 2,
                    child: InkWell
                      (
                      onTap: ( () => showDialog
                        (
                        context: context,
                        builder: (context) =>
                            Dialog
                              (
                                constraints: BoxConstraints
                                  (
                                    maxWidth: 600,
                                    maxHeight: 260,
                                    minHeight: 210,
                                    minWidth: 500
                                  ),
                                child: ConfigWidget()
                              ),
                        )
                      ),
                      borderRadius: BorderRadius.circular(10),
                      child: Container
                        (
                        decoration: BoxDecoration(color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text
                          ("Configurações",
                          style: TextStyle(
                              fontFamily: "Bricolage", color: Colors.white70),
                          textScaler: TextScaler.linear(1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ),
              ],
            )
        )
    );
  }
}

