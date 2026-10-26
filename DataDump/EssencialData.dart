//Lista de dados essencial para mostrar para o usuario e para o agendamento de mensagens

import 'package:flutter/foundation.dart';

import '../BuildingBlocks/SubMenus/ModifyAgen.dart';

ValueNotifier<List<int>> Id = ValueNotifier([]);//ID de cada cliente
ValueNotifier<List<String>> AgenNomes = ValueNotifier([]);//Nome de cada cliente
ValueNotifier<List<int>> AgenNumerosTel = ValueNotifier([]);//Número de telefone de cada cliente
ValueNotifier<List<String>> AgenDataDeContato = ValueNotifier([]);//Data para o primeiro contato com o cliente
ValueNotifier<List<String>> SequenciaDeMensagens = ValueNotifier([]);////Cada entrada da lista é uma senquencia de mensagens pré programadas separadas por pontos
ValueNotifier<List<String>> EstagioAtualDeMensagens = ValueNotifier([]);//Estágio Atual das mensagens enviadas
ValueNotifier<List<int>> AgenRepeat = ValueNotifier([]);//Número de mensagens que vamos mandar no total, meio inutil para o bot mas util para IA
ValueNotifier<List<String>> AgenHorario = ValueNotifier([]);//Horario de contato, tanto o primeiro tanto nas repetições
ValueNotifier<List<String>> AgenTiming = ValueNotifier([]);//Timing entre mensagens

ValueNotifier<List<String>> TalkOptions = ValueNotifier([]);//Dont remember the original use but ig i will use this to store all the message options?

ValueNotifier<int> NumeroQueDispara = ValueNotifier(0);//Número que usaremos
ValueNotifier<String> NomeQueDispara = ValueNotifier("");//Nome que do BOT/IA

int Instance = 0;//Instancia muda dinamicamente dependendo de qual usuario estamos olhando
int TotalEntryNUmber = 0;

//TempData //Todos as variaveis de tempdata tem que ter seus valores descartados antes do proximo uso//Valores dos textboxes são salvos aqui antes de serem adicionados
String NomeTemporario = "DummyNameLucianoTest";
int NumeroTemporario = 0;
String DataTemporaria = "0/0/0";
String SequenciaTemporaria = "0.0.0.0";
String EstagioDasMensagensTemporario = "Invalid";//Needs to be a list of message ids, needs a layer of abstraction between the ids and the user
int RepeatTemporaria = 0;
String HorarioTemp = "-1.-1";
String TimingTemp = "Invalid";

void CleanTemps()
{
  NomeTemporario = "DummyNameLucianoTest";
  NumeroTemporario = 0;
  DataTemporaria = "0/0/0";
  SequenciaTemporaria = "0.0.0.0";
  EstagioDasMensagensTemporario = "Invalid";
  RepeatTemporaria = 0;
  HorarioTemp = "-1.-1";
  TimingTemp = "Invalid";
}
void CleanEssencial()
{
  Id.value.clear();
  AgenNomes.value.clear();
  AgenNumerosTel.value.clear();
  AgenDataDeContato.value.clear();
  SequenciaDeMensagens.value.clear();
  EstagioAtualDeMensagens.value.clear();
  AgenRepeat.value.clear();
  AgenHorario.value.clear();
  AgenTiming.value.clear();
}

