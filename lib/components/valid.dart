import 'package:noteapp/constant/message.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
  if (val.length > max) {
    return "$messageInputMax $max";
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
}

validInputNote(String valNote, int min, int max) {
  if (valNote.isEmpty) {
    return "one of feilds cannot be empty";
  }
}
