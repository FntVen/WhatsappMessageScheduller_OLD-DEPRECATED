import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'HomePoint.dart';
import 'package:untitled/Control/CsvControl.dart';
import 'package:untitled/DataDump/EssencialData.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions
    (
      title: "Whatsapp Agendamentos",
      minimumSize: Size(1000,650),
    );
  windowManager.waitUntilReadyToShow(windowOptions, () async
      {
        await windowManager.show();
        await windowManager.focus();
      });
  CsvReadBulk();
  CsvDialogRead();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: "Bricolage"),
    home: home()
  ));
}