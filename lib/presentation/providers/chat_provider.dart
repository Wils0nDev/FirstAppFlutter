import 'package:flutter/cupertino.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/helpers/get_yes_no_answer.dart';

/** ChangeNotifier: notifica cuando hay cambios
 * Con Provider: 
 */
class ChatProvider extends ChangeNotifier { 

 //creo una instancia de mi clase GetYesNoAnswer
 final getYesNoAnswer = GetYesNoAnswer();

 final ScrollController chatScrollController = ScrollController();
 List<Message> messageList = [
   Message(text: 'Hola bebe',imageUrl: '', fromWho: FromWho.hers),
   Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me)
 ];

 //sendMessaje es un metodo que usaremos para enviar mensajes
 Future<void>sendMessaje(String text) async {
    if(text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    //endsWith: metodo para saber si el texto termina con la letra indicada
    if(text.endsWith('?')){
      herReply();
    }

    //notifyListeners : notifica a todos los que estan escuchando el cambio
    notifyListeners();
     moveScrollToBotton();
 }

 Future<void> herReply() async{

  //obtengo la respuesta del endpoint
  final herMessage = await getYesNoAnswer.getAnswer();
  messageList.add(herMessage);
  notifyListeners();
  moveScrollToBotton();
 }

  Future<void> moveScrollToBotton() async{
    await Future.delayed(
      const Duration(milliseconds: 100)
    );
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeOut);
  }

}