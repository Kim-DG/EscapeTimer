import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/info_type.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';

class MainBloc extends ChangeNotifier{
  final MainRepository _mainRepository = MainRepository();
  late List<EscapeRoom> listRoom;
  int today = 15;

  Future<List<EscapeRoom>> getList() async {
    listRoom = await _mainRepository.getAllRooms();
    return listRoom;
  }

  int calculateDay(EscapeRoom room){
    if(room.etc == "자정"){
      return today+room.day+1;
    }
    return today+room.day;
  }

  String roomInfo(EscapeRoom room, InfoType type) {
    int reservationTime = calculateDay(room);
    if (room.day == 0){
      List<String> time = room.etc.split('/');
      if (type == InfoType.bookmark) {
        return "${room.name}의\n${time[1]}예약은\n${time[0]}입니다.";
      }
      return "${room.name}\n${time[1]} 예약 - ${time[0]}";
    }
    if (type == InfoType.bookmark) {
      return "${room.name}의\n$reservationTime일 예약은\n금일 ${room.etc} 입니다.";
    }
    return "${room.name}\n$reservationTime일 예약 - 금일 ${room.etc}";
  }

}