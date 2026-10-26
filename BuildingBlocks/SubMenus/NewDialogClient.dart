import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/DataDump/EssencialData.dart' as Essencial;
import 'package:untitled/BuildingBlocks/ClientBotDialog.dart' as ClientBot;
import 'package:untitled/Control/Variable/SequenceInterpretation.dart' as SequenceInter;
import 'package:untitled/BuildingBlocks/SubMenus/MakeNewClient.dart' as MakeNewClient;

import 'ModifyAgen.dart';
//Tela para ciação de dialogo 2
bool MakingNewClient = false;

List<DropdownMenuItem<String>> ComboBoxOptions = [];
void SetComboBox()
{
  ComboBoxOptions = Essencial.TalkOptions.value.map((String value)
  {
    return DropdownMenuItem<String>
      (
        value: value,
        child: Text(value)
    );
  }
  ).toList();
}

ValueNotifier<String> CurrentOption = ValueNotifier("DialogosParaBot");

class NewMessageClient extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container
      (
        decoration: BoxDecoration(color: Colors.black87,
        borderRadius: BorderRadius.circular(27)),
        child:Padding
          (
            padding: EdgeInsetsGeometry.all(20),
            child: Column
              (
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  Expanded
                    (
                      child:ValueListenableBuilder
                      (
                        valueListenable: CurrentOption,
                        builder: (context, string, _)
                        {
                              return Container
                              (
                                alignment: Alignment.center,
                                margin: EdgeInsetsGeometry.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                                child: DropdownButtonHideUnderline
                                  (
                                    child: DropdownButton
                                      (
                                        items: ComboBoxOptions,
                                        onChanged: (ChoosenOption)
                                        {
                                          if(MakingNewClient == true)
                                          {
                                            MakeNewClient.NewEntryInfo = Essencial.TalkOptions.value.indexOf(ChoosenOption!);
                                          }
                                          else
                                          {
                                            ClientBot.NewEntryInfo = Essencial.TalkOptions.value.indexOf(ChoosenOption!);
                                          }
                                          CurrentOption.value = ChoosenOption;
                                        },
                                        dropdownColor: Colors.grey,
                                        alignment: AlignmentDirectional.topCenter,
                                        borderRadius: BorderRadius.circular(20),
                                        value: CurrentOption.value,
                                        style: TextStyle(color: Colors.white70, height: 0, decoration: TextDecoration.none, fontFamily: "Bricolage"),
                                      )
                                  )
                              );
                        }
                      )
                      ),
                  FloatingActionButton
                    (
                      onPressed: ()
                      {
                        if(MakingNewClient == true)
                        {
                          MakeNewClient.NewCreationRepeat++;
                          MakeNewClient.NewEntry();
                        }
                        else
                        {
                          Essencial.AgenRepeat.value[Essencial.Instance] = Essencial.AgenRepeat.value[Essencial.Instance] + 1;
                          Essencial.AgenRepeat.value = [...Essencial.AgenRepeat.value];
                          AgenRepeatController.text = "${Essencial.AgenRepeat.value[Essencial.Instance]}";
                          ClientBot.NewEntry();
                        }
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.white12,
                      child: Icon
                        (
                          Icons.check_box_rounded,
                          color: Colors.greenAccent,
                        ),
                    )
                ]
              )
          )
      );
  }
}