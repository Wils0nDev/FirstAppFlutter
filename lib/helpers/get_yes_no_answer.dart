import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
    //Para usar peticiones http usaremos el paquete de Pub -> dio
    //ver archivo pubspec.yaml
      final _dio = Dio();

  Future<Message> getAnswer() async{
    
    final response = await _dio.get('https://yesno.wtf/api');
     
     //Segun el Future tengo q retornar un tipo Message
     //A esto se le llama Mappers
     final yesNoModel = YesNoModel.fromJsonMap(response.data);
    return yesNoModel.toMessageEntity();
    //para arrojar un error
   // throw UnimplementedError();
  }
}