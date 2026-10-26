import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/BuildingBlocks/SubMenus/NewDialogClient.dart';
import 'package:untitled/Control/CsvControl.dart';
import 'package:untitled/DataDump/EssencialData.dart';
import 'package:untitled/BuildingBlocks/ClientBotDialog.dart';

TextEditingController AgenRepeatController = TextEditingController(text: "${AgenRepeat.value[Instance]}");
TextEditingController ClientDataController = TextEditingController(text: "${AgenDataDeContato.value[Instance]}");//Controller para formatar data
int PreviousDataLength = 0;
TextEditingController ClientHourController = TextEditingController(text: "00");
TextEditingController ClientMinuteController = TextEditingController(text: "00");

List<DropdownMenuItem<String>> AgendamentoOptions = [];
ValueNotifier<String> CurrentAgendamentoOptions = ValueNotifier<String>("");

List<String> HourMinute = ["00","00"];

void ModifyStartup()
{
  List<String> AgendamentoTimes = ['Diariamente','Semanalmente','Mensalmente'];
  AgendamentoOptions = AgendamentoTimes.map((String value)
  {
    return DropdownMenuItem<String>
      (
        value: value,
        child: Text(value)
    );
  }
  ).toList();
  CurrentAgendamentoOptions.value = AgenTiming.value[Instance];
  List<String> CurrentTime = AgenHorario.value[Instance].split(".");
  ClientHourController.text = CurrentTime[0];
  ClientMinuteController.text = CurrentTime[1];
}

class ModifyWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return  Container
      (
      decoration: BoxDecoration(color: Colors.black87,
      borderRadius: BorderRadius.circular(27)),
      child: Padding
        (
          padding: EdgeInsetsGeometry.all(20),
          child: SingleChildScrollView
            (
              child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                  Text
                  (
                  "Informações do Cliente",
                  style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                  textAlign: TextAlign.left,
                  ),
                    Expanded //Campo 1
                      (
                        flex: 0,
                        child: Container
                          (
                            alignment: Alignment.center,
                            margin: EdgeInsetsGeometry.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                            child: TextFormField
                              (
                              onChanged: (TempPhone)
                              {
                                if(TempPhone.length >= 11)
                                {
                                  NumeroTemporario = int.parse(TempPhone);
                                }
                              },
                              initialValue: "${AgenNumerosTel.value[Instance]}",
                              maxLength: 11,
                              maxLines: 1,
                              decoration: InputDecoration
                                (
                                contentPadding: EdgeInsetsGeometry.all(10),
                                label: Text("Número para o Disparo de Mensagens", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
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
                        flex: 0,
                        child: Container
                          (
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                            alignment: Alignment.center,
                            margin: EdgeInsetsGeometry.all(10),
                            child: TextFormField
                              (
                              onChanged: (TempNewName)
                              {
                                NomeTemporario = TempNewName;
                              },
                              initialValue: "${AgenNomes.value[Instance]}",
                              maxLength: 100,
                              maxLines: 1,
                              decoration: InputDecoration
                                (
                                  contentPadding: EdgeInsetsGeometry.all(10),
                                  label: Text("Nome do Cliente", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                  border: InputBorder.none
                              ),
                            )
                        )
                    ),
                    Text
                      (
                      "Detalhes do Agendamento",
                      style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                      textAlign: TextAlign.left,
                    ),
                    Expanded //Campo 3
                      (
                        flex: 0,
                        child: Container
                          (
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                            alignment: Alignment.center,

                            margin: EdgeInsetsGeometry.all(10),
                            child: TextFormField
                              (
                              selectAllOnFocus: false,
                              controller: ClientDataController,
                              onChanged: (TempDate)
                              {
                                if(TempDate.length == 2 && PreviousDataLength == 1)
                                {
                                  ClientDataController.text = "$TempDate/";
                                }
                                if(TempDate.length == 5 && PreviousDataLength == 4)
                                {
                                  ClientDataController.text = "$TempDate/";
                                }
                                if(TempDate.length == 10)
                                {
                                  DataTemporaria = TempDate;
                                }
                                PreviousDataLength = TempDate.length;
                              },
                              maxLength: 10,
                              maxLines: 1,
                              decoration: InputDecoration
                                (
                                  contentPadding: EdgeInsetsGeometry.all(10),
                                  label: Text("Data do disparo (01/01/202X)", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                  border: InputBorder.none
                              ),
                            )
                        )
                    ),
                    Padding
                      (
                        padding: EdgeInsetsGeometry.fromLTRB(0, 5, 10, 10),
                        child: Row
                        (
                           mainAxisSize: MainAxisSize.min,
                           spacing: 6,
                           children:
                           [
                             Expanded
                             (
                               flex: 1,
                               child: Container
                               (
                                 alignment: Alignment.center,
                                 margin: EdgeInsetsGeometry.all(10),
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                                 child: SizedBox
                                 (
                                   width: 300,
                                   height: 72,
                                   child: TextFormField
                                   (
                                     selectAllOnFocus: false,
                                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                     maxLength: 2,
                                     maxLines: 1,
                                     controller: ClientHourController,
                                     decoration: InputDecoration
                                     (
                                       contentPadding: EdgeInsetsGeometry.all(10),
                                       label: Text("Horas (Horario Militar)", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                       border: InputBorder.none,
                                     ),
                                     onChanged: (HourChanged)
                                     {
                                       if(HourChanged.length != 0)
                                       {
                                         int HourInt = int.parse(HourChanged);
                                         if(HourInt > 24)
                                         {
                                           HourChanged = "24";
                                           ClientHourController.text = "24";
                                         }
                                         if(HourInt < 0)
                                         {
                                           HourChanged = "0";
                                           ClientHourController.text = "0";
                                         }
                                         HourMinute[0] = HourChanged;
                                       }
                                     },
                                   )
                                 )
                               )
                             ),
                             Text
                             (
                             ":",
                             style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                             textAlign: TextAlign.left,
                             textScaler: TextScaler.linear(2),
                           ),
                             Expanded
                               (
                                 flex: 1,
                                 child: Container
                                   (
                                     alignment: Alignment.center,
                                     margin: EdgeInsetsGeometry.all(10),
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                                     child: SizedBox
                                       (
                                         width: 300,
                                         height: 72,
                                         child: TextFormField
                                           (
                                           selectAllOnFocus: false,
                                           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                           maxLength: 2,
                                           maxLines: 1,
                                           controller: ClientMinuteController,
                                           decoration: InputDecoration
                                             (
                                             contentPadding: EdgeInsetsGeometry.all(10),
                                             label: Text("Minutos", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                             border: InputBorder.none,
                                           ),
                                           onChanged: (MinuteChanged)
                                           {
                                             if(MinuteChanged.length != 0)
                                             {
                                               int MinuteInt = int.parse(MinuteChanged);
                                               if(MinuteInt > 60)
                                               {
                                                 MinuteChanged = "60";
                                                 ClientMinuteController.text = "60";
                                               }
                                               if(MinuteInt < 0)
                                               {
                                                 MinuteChanged = "0";
                                                 ClientMinuteController.text = "0";
                                               }
                                               HourMinute[1] = MinuteChanged;
                                             }
                                           },
                                         )
                                     )
                                 )
                             ),
                           ]
                        )
                      ),
                    Expanded
                      (
                        flex: 0,
                        child: Container
                          (
                          width: double.infinity,
                          height: 60,
                          child: ValueListenableBuilder
                            (
                              valueListenable: CurrentAgendamentoOptions,
                              builder: (context, value, _)
                              {
                                return Padding
                                  (
                                  padding: EdgeInsetsGeometry.all(3),
                                  child:  Container
                                    (
                                      padding: EdgeInsetsGeometry.fromLTRB(10, 0, 0, 0),
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                      child: DropdownButtonHideUnderline
                                        (
                                          child: DropdownButton
                                            (
                                              items: AgendamentoOptions,
                                              dropdownColor: Colors.grey,
                                              alignment: AlignmentDirectional.topCenter,
                                              borderRadius: BorderRadius.circular(20),
                                              value: CurrentAgendamentoOptions.value,
                                              style: TextStyle(color: Colors.white70, height: 0, decoration: TextDecoration.none, fontFamily: "Bricolage"),
                                              onChanged: (ChangedBox)
                                              {
                                                CurrentAgendamentoOptions.value = ChangedBox!;
                                                TimingTemp = ChangedBox!;
                                              }
                                          )
                                      )
                                  ),
                                );
                              }
                          ),
                        )
                    ),
                    Text
                      (
                      "Informações das Mensagens",
                      style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                      textAlign: TextAlign.left,
                    ),
                    Expanded //Campo 4
                      (
                        flex: 0,
                        child: Container
                          (
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                            alignment: Alignment.center,
                            margin: EdgeInsetsGeometry.all(10),
                            child: TextFormField
                              (
                              onChanged: (TempStage)
                              {
                                EstagioDasMensagensTemporario = TempStage;
                              },
                              initialValue: "${EstagioAtualDeMensagens.value[Instance]}",
                              maxLength: 10,
                              maxLines: 1,
                              decoration: InputDecoration
                                (
                                  contentPadding: EdgeInsetsGeometry.all(10),
                                  label: Text("Estágio Atual do Disparo de Mensagens de 1 a 10", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                  border: InputBorder.none
                              ),
                            )
                        )
                    ),
                    Padding
                      (
                        padding:EdgeInsetsGeometry.fromLTRB(10, 8, 0, 10),
                        child: Row
                          (
                            spacing: 10,
                            children:
                            [
                              Expanded //Campo 5
                                (
                                  flex: 1,
                                  child: Container
                                    (
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                                      alignment: Alignment.center,
                                      margin: EdgeInsetsGeometry.all(1),
                                      child: TextFormField
                                        (
                                        readOnly: true,
                                        style: TextStyle(color: Colors.black38),
                                        inputFormatters:
                                        [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (TempRepeat)
                                        {
                                          int a = int.parse(TempRepeat);
                                          if(a > 0)
                                          {
                                            if(a <= 10)
                                            {
                                              RepeatTemporaria = a;
                                            }
                                            else
                                            {
                                              RepeatTemporaria = 10;
                                            }
                                          }
                                          else
                                          {
                                            RepeatTemporaria = 1;
                                          }
                                        },
                                        controller: AgenRepeatController,
                                        maxLength: 10,
                                        maxLines: 1,
                                        decoration: InputDecoration
                                          (

                                            contentPadding: EdgeInsetsGeometry.all(10),
                                            label: Text("Número de Mensagens em Sequencia", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                            border: InputBorder.none
                                        ),
                                      )
                                    )
                              ),
                              FloatingActionButton
                                (
                                splashColor: Colors.white,
                                backgroundColor: Colors.white10,
                                onPressed: ()
                                async {
                                  await GetEntries();//Sets the data for next screen
                                  MakingNewClient = false;
                                  Navigator.push
                                    (
                                      context,
                                      MaterialPageRoute(builder: (context) => ListMessagesClient())
                                    ); //Finish the navigation
                                },
                                child: Icon(Icons.add_box_rounded ,color: Colors.greenAccent,),
                              ),
                            ],
                          )
                      ),
                    Padding
                      (
                      padding: EdgeInsetsGeometry.fromLTRB(125, 0, 125, 0),
                      child: Row
                        (
                          spacing: 70,
                          children:
                          [
                            FloatingActionButton
                              (
                              splashColor: Colors.white,
                              backgroundColor: Colors.white10,
                              onPressed: ()
                              {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.remove_circle_rounded,color: Colors.yellowAccent,),
                            ),
                            FloatingActionButton
                              (
                              splashColor: Colors.white,
                              backgroundColor: Colors.white10,
                              onPressed: ()
                              {
                                CsvDeleteEntry();
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.highlight_remove_rounded,color: Colors.redAccent,),
                            ),
                            FloatingActionButton
                              (
                              splashColor: Colors.white,
                              backgroundColor: Colors.white10,
                              onPressed: ()
                              {
                                CsvReplaceEntry(NomeTemporario, NumeroTemporario, EstagioDasMensagensTemporario, DataTemporaria, RepeatTemporaria, "0.0.0.0","${HourMinute[0]}.${HourMinute[1]}",TimingTemp);
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.add_alarm_rounded,color: Colors.greenAccent,),
                            ),
                          ],
                        )
                    )
                  ],
                )
            )
        ),
    );
  }
}