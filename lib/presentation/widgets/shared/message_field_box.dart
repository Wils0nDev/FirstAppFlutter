import 'package:flutter/material.dart';
class MessageFieldText extends StatelessWidget {
  //ValueChanged : es un tipo que informa cuando un valor ah cambiado
  //
  final ValueChanged<String> valueChange;
  const MessageFieldText({super.key,required this.valueChange});

  @override
  Widget build(BuildContext context) {
    //final colors = Theme.of(context).colorScheme;
    //final List<String> counText = []; 
    int countT = 0;
    //TextEditingController : nos da control del input asociado, con esto podemos obtener su 
    //valor de la caja de texto 
    final textController = TextEditingController();
    //FocusNode : para colocar un foco a un elemento
    final focusNode =  FocusNode();
    /**
     * UnderlineInputBorder : es un widget que nos permite dibujar 
     * un border bottom a las  InputDecorator's, tambien define la forma.
     */
    final outlineInputBorder = UnderlineInputBorder(
      /** BorderSide : es un widget que nos permite crear borders*/
      borderSide:  const BorderSide(
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(40)
    );

    /*inputDecoration : es un widget que nos permite  modelar nuestra 
    caja de texto*/
    final inputDecoration =  InputDecoration(
      //hintText : es un mensaje que muestra una idea de lo que se tiene q escribir
      hintText: 'Escribe tu mensaje',
       /**enabledBorder : nos permite llamar un widget InputBorder*/
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        //True : la decoración de la caja de texto se pinta de gris
        filled: true,
        counterText: '$countT characters',
        //suffixIcon : de tipo widget, se le puede pasar un iconbutton 
        //q se hace parte de la caja de texto
        //IconButton : es un icono con funciones de un boton
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined), 
          //onPressed es como el evento onclick, captura los datos al momento de presionar el boton
          onPressed: () {
            //aqui tomamos el valor del texto escrito en el input
            final textValue = textController.value.text;
            valueChange(textValue);
            //tambien limpiamos despues de obtener el valor
            textController.clear();
          },
          )
      );
    //TextFormField : widget de caja de texto escritura
    return TextFormField(
      // onTap: () {
      //      FocusScope.of(context).requestFocus(FocusNode());
      // },
     //focusNode : nos coloca el foco en el input
      focusNode: focusNode,
      //controller : controla el input
      controller: textController,
      //decoration nos permite llamar a un inputDecoration
      decoration:inputDecoration,
      //textAlign: TextAlign.center, //coloca el texto en el centro
      //onFieldSubmitted: me captura el evento de envio desde el enter
      onFieldSubmitted: (value) {
        
        //como ya tenemos el control del input, podemos limpiarlo
        textController.clear();
        //requestFocus: mantiene el focus, en este caso el input se mantiene abierto
        focusNode.requestFocus();
        valueChange(value);
      },
      //onChange me captura lo que se va escribiendo desde el teclado
      // onChanged: (value) {
      //   counText.add(value);
      // },
    );
  }
}