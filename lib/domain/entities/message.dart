
enum FromWho {me, hers}

class Message {
  final String text;
  final String? imageUrl; //significa que puede ser nulo
  final FromWho fromWho;
  final DateTime sentTime;

  Message({required this.text, this.imageUrl, required this.fromWho, required this.sentTime});

}