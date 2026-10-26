import 'package:untitled/BuildingBlocks/SubMenus/ModifyAgen.dart';
import 'package:untitled/DataDump/EssencialData.dart';
import 'package:untitled/Control/Variable/SequenceInterpretation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'SubMenus/NewDialogClient.dart';

ValueNotifier<List<String>> MessageEntries = ValueNotifier([]);//MessageEntries will be modified every time, so valuelistenablebuilder needs to be tied to it
List<int> IdEntries = []; //Will mirror the MessageEntry list, but using the message IDs instead of the actual messages
List<int> ModifiedEntryId = [];
List<DropdownMenuItem<String>> MessageOptions = [];
int NewEntryInfo = 0;

Future<void> GetEntries()
async {
  List<String> ListOfIds = GetSequence(SequenciaDeMensagens.value[Instance]);
  List<int> TempIntIds = [];
  for(int i = 0; i <= ListOfIds.length - 1; i++)
  {
    TempIntIds.add(int.parse(ListOfIds[i]));
  }
  IdEntries = [...TempIntIds];
  TempIntIds = [];
  ModifiedEntryId = [...IdEntries];
  MessageEntries.value = [...FetchMessagesById(IdEntries)];

  SetMenuItems();
}

void SetMenuItems()
{
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

Future<void> SaveEntries()
async{
  IdEntries = [... ModifiedEntryId];

  String MessageString = SetSequence(ModifiedEntryId);
  SequenciaDeMensagens.value[Instance] = MessageString;
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

class ListMessagesClient extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        backgroundColor: Colors.white12,
        appBar: AppBar
          (
            title: Text("Mensagens programadas para cliente ${AgenNomes.value[Instance]}",
            style: TextStyle(color: Colors.white), textScaler: TextScaler.linear(0.8),),
            backgroundColor: Colors.greenAccent[400],
            leading: BackButton
              (
              onPressed: ()
              {
                SaveEntries();
                AgenRepeat.value = [...AgenRepeat.value];
                Navigator.pop(context);
              }),
          ),
        floatingActionButton: FloatingActionButton
          (
          onPressed:()
          {

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
                    child:Container
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
                                  itemBuilder: (context, DialogInt/*0 based index*/)
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
                                              child: Container//Containers vão ter o texto escrito neles, precisamos apenas das opções de apagar os adicionar containers
                                                (
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                                  child: DropdownButtonHideUnderline
                                                    (
                                                      child: DropdownButton
                                                        (
                                                        items: MessageOptions,
                                                        onChanged: (ChoosenOption)
                                                        {
                                                          int IdToReplacing = TalkOptions.value.indexOf(ChoosenOption!);
                                                          if(IdToReplacing != 0)
                                                          {
                                                            UpdateEntries(DialogInt, IdToReplacing);
                                                          }
                                                        },
                                                        dropdownColor: Colors.grey,
                                                        alignment: AlignmentDirectional.topCenter,
                                                        borderRadius: BorderRadius.circular(20),
                                                        value: "${MessageEntries.value[DialogInt]}",
                                                        style: TextStyle(color: Colors.white70, height: 0, decoration: TextDecoration.none, fontFamily: "Bricolage"),

                                                      )
                                                    )
                                              ),
                                            ),
                                            FloatingActionButton//botão para deletar mensagem
                                              (
                                              onPressed: ()
                                              {
                                                AgenRepeat.value[Instance] = AgenRepeat.value[Instance] - 1;
                                                AgenRepeat.value = [...AgenRepeat.value];
                                                AgenRepeatController.text = "${AgenRepeat.value[Instance]}";
                                                DeleteEntry(DialogInt);
                                              },
                                              splashColor: Colors.white,
                                              backgroundColor: Colors.white10,
                                              child: Icon
                                                (
                                                Icons.remove_circle_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        )
                                    );
                                  }
                              );
                            }
                        )
                    )
                ),

              ]
          ),
        )
      );
  }
}
