import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';
class HerMessageBubble extends StatelessWidget {
  final Message message;
  const HerMessageBubble({required this.message,super.key});
  @override
  Widget build(BuildContext context) {
    //Theme.of(context) : busca el tema dentro del contexto
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration:  BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(message.text,style: const TextStyle(color:Colors.white),)),
        ),
        const SizedBox(height: 10),
        //Todo: 
        _ImageBubble(message.imageUrl!),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {

  final String img;
  final  imgDefault = 'https://yesno.wtf/assets/yes/8-2f93962e2ab24427df8589131da01a4d.gif';
  
  const _ImageBubble(this.img); 

  @override
  Widget build(BuildContext context) {
    final String imgUpd = img == '' ? imgDefault : img;
    //return const Placeholder(); //es un widget que muestra las dimenciones asignadas por defecto
    
    //MediaQuery nos da información del dispositovo que lo esta ejecutando
    //context: hace referencia al arbol de widgets y dentro de este hay
    // informacion com las dimensiones y diferentes caracteristicas del 
    //dispositvo que lo esta corriendo
    final size = MediaQuery.of(context).size;
    //ClipRRect : widgete que hace borders redeondeados a las img
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      //Image.network : nos permite mostrar imagnes desde un URL
      child: Image.network(
      imgUpd,
      width: size.width * 0.7, //el 70% del tamaño original
      height: 150,
      fit: BoxFit.cover, //Esto le dice que coloque la imagen basada en las dimensiones que se han dado
      //loadingBuilder: Esto nos permite mostrar algo hasta que cargue la imagen
      loadingBuilder: (context, child, loadingProgress) {
        if(loadingProgress == null) return child;

        return Container(
          width: size.width * 0.7,
          height: 150,
          padding: const EdgeInsets.symmetric( horizontal:10, vertical: 5),
          child: const Text('Mi bebe me esta enviando una imagen...'),
        );
      },
      )
      );
  }
}