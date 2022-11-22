import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/info_type.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';

class MainBloc extends ChangeNotifier{
  final MainRepository _mainRepository = MainRepository();
  List<EscapeRoom> allListRoom = [];
  List<EscapeRoom> filterListRoom = [];
  int today = 15;

  Future<List<EscapeRoom>> getList() async {
    if(allListRoom.isEmpty) {
      allListRoom = await _mainRepository.getAllRooms();
      filterListRoom = allListRoom;
    }
    return allListRoom;
  }

  filteringListRoom(String region){
    filterListRoom = allListRoom.where((e) => e.getRegion() == region).toList();
  }

  int calculateDay(EscapeRoom room){
    if(room.etc == "자정"){
      return today+room.day+1;
    }
    return today+room.day;
  }

  String roomInfo(EscapeRoom room, InfoType type) {
    int resDay = calculateDay(room);
    List<String> otherTypeResDay = room.etc.split('/');
    switch(type){
      case InfoType.list:
        return listTypeInfo(room, resDay, otherTypeResDay);
      case InfoType.bookmark:
        return bookmarkTypeInfo(room, resDay, otherTypeResDay);
      case InfoType.dialog:
        return "미구현";
    }
  }

  String listTypeInfo(EscapeRoom room, int resDay, List<String> otherTypeResDay){
    if(room.day == 0){
      return "${room.name}\n${otherTypeResDay[1]} 예약 - ${otherTypeResDay[0]}";
    }
    return "${room.name}\n$resDay일 예약 - 금일 ${room.etc}";
  }
  String bookmarkTypeInfo(EscapeRoom room, int resDay, List<String> otherTypeResDay){
    if(room.day == 0) {
      return "${room.name}의\n${otherTypeResDay[1]}예약은\n${otherTypeResDay[0]}입니다.";
    }
    return "${room.name}의\n$resDay일 예약은\n금일 ${room.etc} 입니다.";
  }
}