import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer{

  // Se cra la instanica de la clase DIO, nos ayudara amanejar peticiones HTTP
  final _dio = Dio();

  //Obtiene la respuesta
  Future<Message> getAnswer() async{
    //Almacenar la petición GET en una variable
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    //Generar un error para obtener una respuesta con un breakpoint
    //throw UnimplementedError();
    return yesNoModel.toMessageEntity();

  }
}