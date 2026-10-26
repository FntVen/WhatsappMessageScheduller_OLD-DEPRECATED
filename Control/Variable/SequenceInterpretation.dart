import 'package:untitled/DataDump/EssencialData.dart';

List<String> GetSequence(String CodedSequence)//Recebe a sequencia de Id de mensagens em forma de uma lista
{
  List<String> DecodedSequence = CodedSequence.split(".");

  return DecodedSequence;
}

String SetSequence(List<int> DecodedSequence)//Recebe a sequencia de Id de mensagens eem forma de string com os elementos separados por pontos
{
  String CodedSequence = "";

  for(int IteradorSequencia = 0; IteradorSequencia <= DecodedSequence.length - 1 ; IteradorSequencia++)
  {
    if(IteradorSequencia == 0)
    {
      CodedSequence = "${DecodedSequence[IteradorSequencia]}";
    }
    else
    {
      CodedSequence = "$CodedSequence.${DecodedSequence[IteradorSequencia]}";
    }
  }
  return CodedSequence;
}
List<String> FetchMessagesById(List<int> IdList)
{
  List<String> ListMessages = [];
  for(int i = 0; i <= IdList.length - 1; i++)
  {
    ListMessages.add(TalkOptions.value[IdList[i]]);
  }
  return ListMessages;
}