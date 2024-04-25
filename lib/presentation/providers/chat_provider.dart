import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  //Controlador para manejar la posicion de scroll
  final ScrollController chatScrollController = ScrollController();

  List<Message> messageList = [
    // Message(text: 'Hola amor!', fromWho: FromWho.me),
    // Message(
    //   text: 'Ya regresaste del trabajo?',
    //   fromWho: FromWho.me),
  ];

  int _messageCount = 0;

  Future<void> sendMessage(String  text) async {

    _messageCount++; // Incrementa el contador de mensajes
    print('Mensaje enviado: $_messageCount ');

    if (text.isEmpty) return; //Para evitar que se muestren mensajes vacios

    //El mensaje siempre va ser de "me" (o mio) por que yo usuario siempre sera que envie el mensaje
    final newMessage = Message(text: text, fromWho: FromWho.me);
    // Agregar un mensaje a lista
    messageList.add(newMessage);

    //Notificar si algo del provider cambio para que se guarde en el estado
    notifyListeners();
    moveScrollController();
  }

  Future<void> moveScrollController () async{
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
      //maxScrollExtent determina lo maximo que el scroll puede dar
      chatScrollController.position.maxScrollExtent,
      //offset, //Posicion de la animacion
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut);
  }
}