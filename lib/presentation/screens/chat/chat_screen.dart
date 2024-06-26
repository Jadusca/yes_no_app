import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://pyraxadon.files.wordpress.com/2021/09/screen-shot-2021-08-20-at-5.38.53-am.png?w=1200'),
          ),
        ),
        title: const Text('Mi amorcito ❤️🥺'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                //Enlaza al controlador creado en chatProvider
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length, //Se pone la longitud de la lista que se encuentra en ChatProvider
                itemBuilder: (context, index) {
                  //Instancia del message que sabra de quien es el mensaje.
                  final message = chatProvider.messageList[index];
                  //Asigna MessageBubble a partir de quien venga el mensaje
                return (message.fromWho == FromWho.hers)
                ? HerMessageBubble(message: message)
                : MyMessageBubble(message: message,);
              })),

              //caja de texto mesajes que llama el metodo provider para enviar el mensaje
            MessageFieldBox(onValue: chatProvider.sendMessage),
          ],
        ),
      ),
    );
  }
}