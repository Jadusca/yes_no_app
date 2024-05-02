import 'package:yes_no_app/domain/entities/message.dart';

// El modelo define que datos debe contener la aplicación
class YesNoModel {

  //Atributos de la clase
  final String answer;
  final bool forced;
  final String image;

  //Constructor con los atributos
  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image});

  // Sirve para crear una breve instancia
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
  answer: json ["answer"],
  forced: json ["forced"],
  image: json ["image"]
  );

  Message toMessageEntity() => Message(
    //Condicion para darle el valor el mensaje
    text: answer == 'yes' ? 'Sí' : (answer == 'maybe' ? 'maybe' : 'No'),
    fromWho: FromWho.hers,
    imageUrl:image
    );

}

