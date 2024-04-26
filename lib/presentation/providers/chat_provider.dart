import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  //Controlador para manejar la posicion de scroll
  final ScrollController chatScrollController = ScrollController();
  //Instancia de la clase GetYesNoAnswer
  final getYesNoAnswer = GetYesNoAnswer();

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
    //Detecta si el usuario hizo una pregunta para desencadenar la respuesta "ella"
      if (text.endsWith('?')){
        herReply();
      }

    //Notificar si algo del provider cambio para que se guarde en el estado
    notifyListeners();
    moveScrollController();
  }

  //Creara la respuesta de "ella"
  Future<void> herReply() async{
    //Obtener petición y almacenarlo en una variable
    final herMessage = await getYesNoAnswer.getAnswer();
    //añadir en la lista de mensajes
    messageList.add(herMessage);
    //Notificar si algo de provider cambio para que se guarde en el estado
    notifyListeners();
    //Mueve el scroll hasta el ultimo mensaje recibido
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