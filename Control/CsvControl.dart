import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:untitled/Control/Variable/SequenceInterpretation.dart';
import 'package:untitled/DataDump/EssencialData.dart';

void CsvWriteNewEntry()
{
  int LastId = Id.value.last;
  String LatestName = AgenNomes.value.last;
  int LastNumber = AgenNumerosTel.value.last;
  String LastDate = AgenDataDeContato.value.last;
  int LastRepeat = AgenRepeat.value.last;
  String LastSequence = SequenciaDeMensagens.value.last;
  String LastEstagio = EstagioAtualDeMensagens.value.last;
  String LastHorario = AgenHorario.value.last;
  String LastTiming = AgenTiming.value.last;
  var Entry = File(Path.join("lib","Control","Variable","ClientLog.csv"));
  try
  {
   //Manually append all this info and write to the file
    //CSV ordem | Id,Nome,Telefone,Estágio,DataDeContato,Repetições,Horario
    var Entry = File(Path.join("lib","Control","Variable","ClientLog.csv"));
    String NewEntry = "$LastId,$LatestName,$LastNumber,$LastEstagio,$LastDate,$LastRepeat,$LastSequence,$LastHorario,$LastTiming";
    Entry.writeAsStringSync("\n$NewEntry", mode: FileMode.append);
    CsvReadBulk();
  }
  catch(e)
  {}
}

void CsvReadBulk()//lê as informações já escritas pelos usos anteriores
{
 try
 {
   var Entry = File(Path.join("lib","Control","Variable","ClientLog.csv"));
    List<String> DataLines = [];
    List<String> conteudo = Entry.readAsLinesSync();
    if(conteudo.length > 1)
    {
      CleanEssencial();
    }
    for(int IteradorLinhas = 0; IteradorLinhas <= conteudo.length - 1; IteradorLinhas++)
    {
      if(IteradorLinhas != 0)
      {
        DataLines.add(conteudo[IteradorLinhas]);
      }
    }
    for(int IteradorLinhas = 0; IteradorLinhas <= DataLines.length - 1; IteradorLinhas++)
    {
      bool RepeatedEntry = false;
      List<String> Data = DataLines[IteradorLinhas].split(',');//Data irá representar os segmentos/colunas da linha atual
      //CSV ordem | Id,Nome,Telefone,Estágio,DataDeContato,Repetições,Horario
      for(int IteradorDeColunas = 0; IteradorDeColunas <= Id.value.length - 1; IteradorDeColunas++)
      {
        if(Id.value[IteradorDeColunas] == int.parse(Data[0]))
        {
          if(AgenNomes.value[IteradorDeColunas] == Data[1])
          {
            RepeatedEntry = true;
            break;
          }
        }
      }
      if(RepeatedEntry)
      {
        continue;
      }
      Id.value = [...Id.value, int.parse(Data[0])];
      AgenNomes.value = [/*What the hell is this syntax */...AgenNomes.value, Data[1]];
      AgenNumerosTel.value = [...AgenNumerosTel.value, int.parse(Data[2])];
      EstagioAtualDeMensagens.value = [...EstagioAtualDeMensagens.value, Data[3]];
      AgenDataDeContato.value = [...AgenDataDeContato.value, Data[4]];
      AgenRepeat.value = [...AgenRepeat.value, int.parse(Data[5])];
      SequenciaDeMensagens.value = [...SequenciaDeMensagens.value, Data[6]];
      AgenHorario.value = [...AgenHorario.value, Data[7]];
      AgenTiming.value = [...AgenTiming.value, Data[8]];
    }

 }
 catch (e)
 {

 }

}

void CsvReplaceEntry(String NewName, int NewPhone, String NewMessage, String NewDate, int NewRepeat, String NewSequence, String NewHorario, String NewTiming)
{
  if(Instance <= Id.value.length - 1 && Instance > -1)
  {
    //Começo Internamente
    if(NomeTemporario != "DummyNameLucianoTest")
    {
      String CurrentName = AgenNomes.value[Instance];
      List<String> TempName = AgenNomes.value.map((e) => e == CurrentName ? NewName : e).toList();
      AgenNomes.value = [...TempName];
    }
    if(NumeroTemporario != 0)
    {
      int CurrentPhone = AgenNumerosTel.value[Instance];
      List<int> TempPhone = AgenNumerosTel.value.map((e) => e == CurrentPhone ? NewPhone : e).toList();
      AgenNumerosTel.value = [...TempPhone];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(EstagioDasMensagensTemporario != "Invalid")
    {
      String CurrentMessage = EstagioAtualDeMensagens.value[Instance];
      List<String> TempMessage = EstagioAtualDeMensagens.value.map((e) => e == CurrentMessage ? NewMessage : e).toList();
      EstagioAtualDeMensagens.value = [...TempMessage];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(DataTemporaria != "0/0/0")
    {
      String CurrentDate = AgenDataDeContato.value[Instance];
      List<String> TempDate = AgenDataDeContato.value.map((e) => e == CurrentDate ? NewDate : e).toList();
      AgenDataDeContato.value = [...TempDate];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(RepeatTemporaria != 0)
    {
      int CurrentRepeat = AgenRepeat.value[Instance];
      List<int> TempRepeat = AgenRepeat.value.map((e) => e == CurrentRepeat ? NewRepeat : e).toList();
      AgenRepeat.value = [...TempRepeat];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(SequenciaTemporaria != "0.0.0.0" && NewSequence != "0.0.0.0")
    {
      String CurrentSequence = SequenciaDeMensagens.value[Instance];
      List<String> TempSequence = SequenciaDeMensagens.value.map((e) => e == CurrentSequence ? NewSequence : e).toList();
      SequenciaDeMensagens.value = [...TempSequence];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(HorarioTemp != "-1.-1")
    {
      String CurrentHorario = AgenHorario.value[Instance];
      List<String> TempHorario = AgenHorario.value.map((e) => e == CurrentHorario ? NewHorario : e).toList();
      AgenHorario.value = [...TempHorario];
      AgenNomes.value = [...AgenNomes.value];
    }
    if(TimingTemp != "Invalid")
    {
      String CurrentTiming = AgenTiming.value[Instance];
      List<String> TempTiming = AgenTiming.value.map((e) => e == CurrentTiming ? NewTiming : e).toList();
      AgenTiming.value = [...TempTiming];
      AgenNomes.value = [...AgenNomes.value];
    }
    //Modificar Arquivo CSV
    String MasterMessage = "Id,Nome,Telefone,Estágio,DataDeContato,Repetição,Sequencia,Horario,Timing";
    for(int i = 0; i <= Id.value.length - 1; i++)
    {
      MasterMessage = "$MasterMessage\n${Id.value[i]},${AgenNomes.value[i]},${AgenNumerosTel.value[i]},${EstagioAtualDeMensagens.value[i]},${AgenDataDeContato.value[i]},${AgenRepeat.value[i]},${SequenciaDeMensagens.value[i]},${AgenHorario.value[i]},${AgenTiming.value[i]}";
    }
    try
    {
      var Entry = File(Path.join("lib","Control","Variable","ClientLog.csv"));
      Entry.writeAsStringSync(MasterMessage);
    }
    catch(e)
    {}
  }

}

void CsvDeleteEntry()
{
  //Modificações Internas
  List<int> TempId = Id.value..removeAt(Instance);
  List<String> TempNameList = AgenNomes.value..removeAt(Instance);
  List<int> TempNumberList = AgenNumerosTel.value..removeAt(Instance);
  List<String> TempDataList = AgenDataDeContato.value..removeAt(Instance);
  List<String> TempMensagemList = EstagioAtualDeMensagens.value..removeAt(Instance);
  List<int> TempRepeateList = AgenRepeat.value..remove(Instance);
  List<String> TempSequence = SequenciaDeMensagens.value..removeAt(Instance);
  List<String> TempHorario = AgenHorario.value..removeAt(Instance);
  List<String> TempTiming = AgenTiming.value..removeAt(Instance);
  Id.value = [...TempId];
  AgenNomes.value = [...TempNameList];
  AgenNumerosTel.value = [...TempNumberList];
  AgenDataDeContato.value = [...TempDataList];
  EstagioAtualDeMensagens.value = [...TempMensagemList];
  AgenRepeat.value = [... TempRepeateList];
  SequenciaDeMensagens.value = [... TempSequence];
  AgenHorario.value = [...TempHorario];
  AgenTiming.value = [...TempTiming];

  for(int i = 0; i <= Id.value.length - 1; i++)
  {
    Id.value[i] = i + 1;
  }

  //ModificarCSV

  var Entry = File(Path.join("lib","Control","Variable","ClientLog.csv"));
  List<String> Conteudo = Entry.readAsLinesSync();
  for(int i = 0; i <= Conteudo.length - 1; i++)
  {
    Conteudo[i];
  }
  List<String> NewConteudo = Conteudo..removeAt(Instance + 1);//Should be Instance + 1 because instance does not count the headerline
  String NewText = "";
  for(int i = 0; i <= NewConteudo.length - 1; i++)
  {
    if(i == 0)
    {
      NewText = NewConteudo[i];
    }
    else
    {
      NewText = "$NewText\n${NewConteudo[i]}";
    }
  }

  Entry.writeAsStringSync(NewText);

}

void CsvDialogRead()//gets the raw message options
{
  var Entry = File(Path.join("lib","Control","Variable","BotDialog.csv"));
  List<String> TempList = Entry.readAsLinesSync();
  if(TempList.length != 0)
  {
    for(int i = 0; i <= TempList.length -1; i++)
    {
        TalkOptions.value.add(TempList[i]);
    }
  }
}
