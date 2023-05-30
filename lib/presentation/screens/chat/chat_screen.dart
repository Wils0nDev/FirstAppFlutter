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
        //leading es un espacio antes del titulo
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://scontent.flim37-1.fna.fbcdn.net/v/t39.30808-6/344820982_938685737283098_8144739180886415462_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeG3awu_7SWx5S_bd7q1hhDPdFzA0iyVxXp0XMDSLJXFerU1GTLyyalO8jpRyFoZo6Dp-Fc7AymoACOF5_lJxy_A&_nc_ohc=n0P-L6nyJkcAX8CBAO8&_nc_oc=AQkUigpLUNrDiVDSBnLqLk4BFeRraThZZHf0YkDQhpCvoCFbVLs62m3dQHZeuQ9a7hs&_nc_ht=scontent.flim37-1.fna&oh=00_AfCyEMU4uK2hBpmJabEcAgTG5hq3EhIQCSAuL_1VMyiIng&oe=6478FA8C'), //NetworkImage : para imagenes url
          ), 
          ), 
        title: const Text('Mi amor ❤️'),  
        centerTitle: false,
      ),
      body:   GestureDetector(
         onTap: (){
                  FocusScope.of(context).requestFocus( FocusNode());
         },
         child: const _ChatView()
         ),
    );
  }
}

class _ChatView extends StatelessWidget {

  const _ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SafeArea : Un widget que inserta a su hijo con suficiente espacio para 
    //evitar intrusiones por parte del sistema operativo, 
    //- Genera padings para eviter colapsar con parte del sistema.
  
  //context.watch es un metodo que la librería Provider extiende al BuildContext
  //Entonces le decimos al método que instancia necesitamos 
  //Esto permite escuchar las notificaciones que vienene de notifyListeners
    // -- revisa el archivo "chat_provider", desde aqui es de donde se envía 
    //el cambio que se hizo a messageList (se le agregan textos).
   final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), //para pading de los costados
        child: Column(
          children: [
            //Expande todo el widget hijo al todo el espacio disponible
            Expanded(
              //ListView.builder es un constructor con nombre de ListView
              //Este permite construir un gran numero de listados de widgets, ya que 
              //el constructor se ejecuta para aquellos elementos que son visibles.
                
              child: ListView.builder(
                //controller : me permite tener el control del scroll
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length, //esta propiedad es la cantidad de veces q recorrera el itemBuilder
                //itemBuilder :recibe dos parametros, context-> arbol de widgets y el index
                //Este es como un foreach que recorre 
                itemBuilder: ((context, index) {
                  final message = chatProvider.messageList[index];
                  return (message.fromWho == FromWho.hers)
                  ?  HerMessageBubble(message:message)
                  :  MyMessageBubble(message:message.text);
                  // return (index % 2 == 0)
                  // ? const HerMessageBubble()
                  // : const MyMessageBubble();
                })
                ),
            ),
            //Caja de texto
            /** Ahora mi widget de caja de texto recibe un valor de tipo ValueChanged 
             * valueChange : seria mi callback q retornara el valor que emitio el ValueChanged
             * value : es el valor que se escribio en la caja de text
             * este valor le enviamos a nuestro sendMessaje
            */
             MessageFieldText(valueChange:(value) => chatProvider.sendMessaje(value),)
          ],
        ),
      ),
    );
  }
}