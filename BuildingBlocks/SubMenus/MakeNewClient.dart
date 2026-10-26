import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/DataDump/EssencialData.dart';
import 'package:untitled/BuildingBlocks/SubMenus/MakeNew.dart';
import '../../Control/Variable/SequenceInterpretation.dart';
import 'MakeNewClient.dart' as MakeNewClient;
import 'NewDialogClient.dart';
//Tela para seleção de dialogo 1 //Screen updates according to "CurrentOption"
//Note to self, have this screen always have a combobox thats un-deletable, and do the same with the other equivalent screen
//Done in this one, but still need to modify the other

List<DropdownMenuItem<String>> MessageOptions = [];//The List of Possible Dialog Options for the comboboxes
List<int> IdEntries = []; //Will mirror the MessageEntry list, but using the message IDs instead of the actual messages
List<int> ModifiedEntryId = []; //The temporary changing version os IdEntries
ValueNotifier<List<String>> MessageEntries = ValueNotifier([]);//Teh list of messages as strings, these will be turned into ComboBox options
int NewEntryInfo = 0;


//TempValues //Maybe replace these with the ones at essencial values
String NewCreationName = "Cliente Novo";
int NewCreationNumber = 0;
String NewCreationData = "";
String NewCretionSequencia = "1";
int NewCreationRepeat = 1;
List<String> NewHour = List.filled(2, "-1");
String NewTiming = "Invalid";

void ClearCreateValues()
{
  NewCreationName = "Cliente Novo";
  NewCreationNumber = 0;
  NewCreationData = "";
  NewCretionSequencia = "1";
  NewCreationRepeat = 1;
  NewRepeatController.text = "${NewCreationRepeat}";
  NewDataController.text = "${NewCreationData}";
  PreviousDataLength = 0;
  NewPhoneController.text = "${NewCreationNumber}";
  PreviousPhoneLength = 0;
  MessageEntries.value = [...MessageEntries.value];
  CurrentAgendamentoOptions.value = AgendamentoOptions[0].value!;
  NewHourController.text = "10";
  NewMinuteController.text = "00";

}

void SetMenuItems()
{
  List<int> Temp = [1];
  ModifiedEntryId = [...Temp];
  IdEntries = [...Temp];
  Temp = [];
  MessageEntries.value = [...FetchMessagesById(IdEntries)];
  MessageOptions = TalkOptions.value.map((String value)
  {
    return DropdownMenuItem<String>
      (
        value: value,
        child: Text(value)
    );
  }
  ).toList();
}

Future<void> UpdateEntries(int IdToReplaceBy, int IdReplacing)//Só pode ser usada quando já temos dados em MessageEntries e IdEntries
async{
  ModifiedEntryId[IdToReplaceBy] = IdReplacing;
  MessageEntries.value = [...FetchMessagesById(ModifiedEntryId)];
}

Future<void> SaveEntries()//Will be used to make new id and save all this info, also updating the main menu
async{

}
Future<void> DeleteEntry(int EntryToDelete)
async{
  ModifiedEntryId.removeAt(EntryToDelete);
  MessageEntries.value = [...FetchMessagesById(ModifiedEntryId)];
}
Future<void> NewEntry()
async{
  ModifiedEntryId.add(NewEntryInfo);
  MessageEntries.value = [...FetchMessagesById(ModifiedEntryId)];
}

List<DropdownMenuItem<String>> ComboBoxOptions = [];
ValueNotifier<String> CurrentOption = ValueNotifier("DialogosParaBot");

void SetupComboBox()
{
  ComboBoxOptions = TalkOptions.value.map((String value)
  {
    return DropdownMenuItem<String>
      (
        value: value,
        child: Text(value)
    );
  }
  ).toList();
}

class NewClientNewMessageWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        backgroundColor: Colors.white12,
        appBar: AppBar
          (
          title: Text("Mensagens programadas para cliente ${NewCreationName}",
            style: TextStyle(color: Colors.white), textScaler: TextScaler.linear(0.8),),
          backgroundColor: Colors.greenAccent[400],
          leading: BackButton
            (
              onPressed: ()
              {
                NewRepeatController.text = "${NewCreationRepeat}";
                NewCretionSequencia = SetSequence(ModifiedEntryId);
                MessageEntries.value = [...MessageEntries.value];
                Navigator.pop(context);
              }),
        ),
        floatingActionButton: FloatingActionButton
          (
            onPressed:()
            {
              MakingNewClient = true;
              MessageEntries.value = [...MessageEntries.value];
              NewRepeatController.text = "${NewCreationRepeat}";
              SetComboBox();
              showDialog
                (
                  context: context,
                  builder: (context) =>
                      Dialog
                        (
                          constraints: BoxConstraints
                            (
                              maxWidth: 600,
                              maxHeight: 180,
                              minHeight: 50,
                              minWidth: 500
                          ),
                          child: NewMessageClient()
                      )
              );
            },
            splashColor: Colors.white,
            backgroundColor: Colors.white10,
            child: Icon(Icons.add_circle_outline_rounded, color: Colors.greenAccent,),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding
        (
         padding: EdgeInsetsGeometry.all(20),
         child: Column
         (
             mainAxisSize: MainAxisSize.min,
             spacing: 20,
             mainAxisAlignment: MainAxisAlignment.center,
           children:
           [
             Expanded
             (
               child: Container
               (
                 padding: EdgeInsetsGeometry.all(20),
                 decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                 width: 2000,
                 height: double.infinity,
                 child: ValueListenableBuilder
                (
                  valueListenable: MessageEntries,
                  builder: (context, list, _)
                  {
                    return ListView.builder
                       (
                         itemCount: MessageEntries.value.length,
                         itemBuilder: (context, NewDialog)
                         {
                           return Padding
                             (
                              padding: EdgeInsetsGeometry.all(20),
                              child: Row
                                (
                                  spacing: 10,
                                  children:
                                  [
                                    Expanded
                                      (
                                        flex: 2,
                                        child: Container
                                          (
                                          width: double.infinity,
                                          height: 60,
                                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                            child: DropdownButtonHideUnderline
                                              (
                                                child: DropdownButton
                                                  (
                                                  items: ComboBoxOptions,
                                                  onChanged: (ChoosenOption)
                                                  {
                                                    UpdateEntries(NewDialog, TalkOptions.value.indexOf(ChoosenOption!));
                                                  },
                                                  dropdownColor: Colors.grey,
                                                  alignment: AlignmentDirectional.topCenter,
                                                  borderRadius: BorderRadius.circular(20),
                                                  value: MessageEntries.value[NewDialog],//Check this again later
                                                  style: TextStyle(color: Colors.white70, height: 0, decoration: TextDecoration.none, fontFamily: "Bricolage"),
                                                )
                                            ),
                                          )
                                      ),
                                    FloatingActionButton
                                      (
                                        onPressed: ()
                                        {
                                          DeleteEntry(NewDialog);
                                          MakeNewClient.NewCreationRepeat--;
                                        },
                                        backgroundColor: Colors.white12,
                                        child: Icon(Icons.remove_circle_rounded, color: Colors.redAccent,),
                                      )
                                  ],
                                ),
                             );
                         }
                    );
                  }
                ),
               )

             ),
           ]
         )
        )
      );
  }
}