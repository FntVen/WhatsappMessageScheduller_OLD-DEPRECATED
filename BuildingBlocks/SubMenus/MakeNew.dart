import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/BuildingBlocks/SubMenus/MakeNewClient.dart' as MakeNewClient;
import 'dart:ui';
import 'package:untitled/Control/CsvControl.dart';
import 'package:untitled/DataDump/EssencialData.dart';
//Primeiro Widget de criação de cliente //Screen updates according to "MessageEntries"
TextEditingController NewRepeatController = TextEditingController(text: "${MakeNewClient.NewCreationRepeat}");//Controller to modify the number in the textbox
TextEditingController NewDataController = TextEditingController(text: "${MakeNewClient.NewCreationData}");//Controller para formatar data
int PreviousDataLength = 0;
TextEditingController NewPhoneController = TextEditingController(text: "${MakeNewClient.NewCreationNumber}");
int PreviousPhoneLength = 0;
TextEditingController NewHourController = TextEditingController(text: "10");
TextEditingController NewMinuteController = TextEditingController(text: "00");

List<DropdownMenuItem<String>> AgendamentoOptions = [];
ValueNotifier<String> CurrentAgendamentoOptions = ValueNotifier<String>("");

void Startup()
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
}

class NewUserWidget extends StatelessWidget
{
  bool MultipleMessages = false;
  @override
  Widget build(BuildContext context)
  {
    return Container
      (
        decoration: BoxDecoration(color: Colors.black87,
        borderRadius: BorderRadius.circular(19)),
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
                    Container
                      (
                        alignment: Alignment.center,
                        margin: EdgeInsetsGeometry.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                        child: TextFormField
                          (
                            maxLength: 100,
                            maxLines: 1,
                            onChanged: (NewName)
                            {
                              NomeTemporario = NewName;
                              MakeNewClient.NewCreationName = NewName;
                            },
                            decoration: InputDecoration
                              (
                              contentPadding: EdgeInsetsGeometry.all(10),
                              label: Text("Nome do Cliente", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                              border: InputBorder.none,
                              ),
                          )
                      ),
                      Container
                      (
                        alignment: Alignment.center,
                        margin: EdgeInsetsGeometry.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                        child: TextFormField
                          (
                          controller: NewPhoneController,
                          selectAllOnFocus: false,
                          maxLength: 14,
                          maxLines: 1,
                          inputFormatters:
                          [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (NewNumber)
                          {
                            if(NewNumber.length == 11)
                            {
                              MakeNewClient.NewCreationNumber = int.parse(NewNumber);
                              String FormattedString = "";
                              List<String> PhoneElementList = [];
                              for(String Character in NewNumber.characters)
                              {
                                PhoneElementList.add(Character);
                              }
                              for(int i = 0; i <= PhoneElementList.length - 1; i++)
                              {
                                if(i == 0)
                                {
                                  FormattedString = "(${PhoneElementList[i]}";
                                  continue;
                                }
                                if(i == 1)
                                {
                                  FormattedString = FormattedString + "${PhoneElementList[i]})";
                                  continue;
                                }
                                if(i == 7)
                                {
                                  FormattedString = FormattedString + "${PhoneElementList[i]}-";
                                  continue;
                                }
                                FormattedString = FormattedString + PhoneElementList[i];
                              }
                              NewPhoneController.text = FormattedString;
                            }
                            PreviousPhoneLength = NewNumber.length;
                          },
                          decoration: InputDecoration
                            (
                            contentPadding: EdgeInsetsGeometry.all(10),
                            label: Text("Numero do Cliente", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    Text
                      (
                      "Detalhes do Agendamento",
                      style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                      textAlign: TextAlign.left,
                    ),
                    Container
                      (
                        alignment: Alignment.center,
                        margin: EdgeInsetsGeometry.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                        child: TextFormField
                          (
                          selectAllOnFocus: false,
                          controller: NewDataController,
                          maxLength: 10,
                          maxLines: 1,
                          onChanged: (NewDate)
                          {
                            if(NewDate.length == 2 && PreviousDataLength == 1)
                            {
                             NewDataController.text = "$NewDate/";
                            }
                            if(NewDate.length == 5 && PreviousDataLength == 4)
                            {
                              NewDataController.text = "$NewDate/";
                            }
                            if(NewDate.length == 10)
                            {
                              MakeNewClient.NewCreationData = NewDate;
                            }
                            PreviousDataLength = NewDate.length;
                          },
                          decoration: InputDecoration
                            (
                            contentPadding: EdgeInsetsGeometry.all(10),
                            label: Text("Data de Primeiro Contato (01/01/202X)", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                            border: InputBorder.none,
                          ),
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
                               width: double.infinity,
                               height: 72,
                               child: TextFormField
                               (
                                  selectAllOnFocus: false,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  maxLength: 2,
                                  maxLines: 1,
                                  controller: NewHourController,
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
                                        NewHourController.text = "24";
                                      }
                                      if(HourInt < 0)
                                      {
                                        HourChanged = "0";
                                        NewHourController.text = "0";
                                      }
                                      MakeNewClient.NewHour[0] = HourChanged;
                                    }
                                  },
                               )
                              )
                             )
                            ),Text
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
                                  width: double.infinity,
                                  height: 72,
                                  child: TextFormField
                                  (
                                    selectAllOnFocus: false,
                                    inputFormatters:
                                    [FilteringTextInputFormatter.digitsOnly],
                                    maxLength: 2,
                                    maxLines: 1,
                                    controller: NewMinuteController,
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
                                          NewMinuteController.text = "60";
                                        }
                                        if(MinuteInt < 0)
                                        {
                                          MinuteChanged = "0";
                                          NewMinuteController.text = "0";
                                        }
                                        MakeNewClient.NewHour[1] = MinuteChanged;
                                      }

                                    },
                                  )
                                )
                              )
                            )
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
                                                      MakeNewClient.NewTiming = ChangedBox!;
                                                      print(MakeNewClient.NewTiming);
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
                      "Listagem de Mensagens",
                      style: TextStyle(color: Colors.white70, fontFamily: "Bricolage"),
                      textAlign: TextAlign.left,
                    ),
                    Padding
                      (
                        padding: EdgeInsetsGeometry.fromLTRB(0, 5, 10, 10),
                        child: ValueListenableBuilder
                          (
                            valueListenable: MakeNewClient.MessageEntries,
                            builder: (context, list, _)
                            {
                              return Row
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
                                            width: double.infinity,
                                            height: 72,
                                            child: TextFormField
                                              (
                                              maxLength: 2,
                                              maxLines: 1,
                                              readOnly: true,
                                              style: TextStyle(color: Colors.black38),
                                              onChanged: (NewRepeat)
                                              {
                                                if(NewRepeat.length >= 2)
                                                {
                                                  RepeatTemporaria = int.parse(NewRepeat);
                                                }
                                              },
                                              controller: NewRepeatController,
                                              inputFormatters:
                                              [
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              decoration: InputDecoration
                                                (
                                                contentPadding: EdgeInsetsGeometry.all(10),
                                                label: Text("Número de Mensagens em Sequencia", style: TextStyle(fontFamily: "Bricolage", color: Colors.white70, fontSize: 20),textAlign: TextAlign.center,),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                    FloatingActionButton
                                      (
                                        onPressed: ()
                                        {
                                          MakeNewClient.SetupComboBox();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => MakeNewClient.NewClientNewMessageWidget()));
                                        },
                                        backgroundColor: Colors.white12,
                                        child:Icon(Icons.add_box_rounded, color: Colors.greenAccent,)
                                    ),

                                  ]
                              );
                            }
                          )

                      ),
                    FloatingActionButton
                      (
                        onPressed: ()
                        {
                          if(MakeNewClient.NewCreationName != "Cliente Novo" && MakeNewClient.NewCreationNumber.toString().length >= 11 && MakeNewClient.NewCreationData.length >= 10 && MakeNewClient.NewHour != ["-1","-1"] && MakeNewClient.NewTiming != "" && MakeNewClient.NewTiming != "Invalid")
                          {
                            int NewLastId = 1;
                            if(Id.value.length != 0)
                            {
                              NewLastId = Id.value.last + 1;
                            }
                            Id.value.add(NewLastId);
                            AgenNomes.value.add(MakeNewClient.NewCreationName);
                            EstagioAtualDeMensagens.value.add("1");
                            AgenDataDeContato.value.add(MakeNewClient.NewCreationData);
                            AgenNumerosTel.value.add(MakeNewClient.NewCreationNumber);
                            SequenciaDeMensagens.value.add(MakeNewClient.NewCretionSequencia);
                            AgenRepeat.value.add(MakeNewClient.NewCreationRepeat);
                            AgenHorario.value.add("${MakeNewClient.NewHour[0]}.${MakeNewClient.NewHour[1]}");
                            AgenTiming.value.add(MakeNewClient.NewTiming);

                            AgenNomes.value = [...AgenNomes.value];
                            CsvWriteNewEntry();
                            CsvReadBulk();
                            Navigator.pop(context);
                          }
                        },
                        backgroundColor: Colors.white12,
                        child: Icon(Icons.check_box_rounded, color: Colors.greenAccent),
                      )
                  ]

                )
              )
          )
      );
  }
}