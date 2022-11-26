import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/info_type.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class MainBloc extends ChangeNotifier{
  MainBloc(){
    _mainRepository = MainRepository();
  }
  late MainRepository _mainRepository;

  List<EscapeRoom> _allListRoom = List.empty();
  List<EscapeRoom> get allListRoom => _allListRoom;
  List<EscapeRoom> _filterListRoom = List.empty();
  List<EscapeRoom> get filterListRoom => _filterListRoom;

  Future<List<EscapeRoom>> getList() async {
    if(allListRoom.isEmpty) {
      _allListRoom = await _mainRepository.getAllRooms();
      _filterListRoom = allListRoom;
      notifyListeners();
    }
    return allListRoom;
  }

  filteringListRoom(String region){
    _filterListRoom = allListRoom.where((e) => e.getRegion() == region).toList();
    notifyListeners();
  }

  String getCalculateDay(EscapeRoom room){
    var date = DateTime.now().add(Duration(days:room.day));
    if (room.etc == "자정") date.add(const Duration(days: 1));
    var day = DateFormat('MM/dd').format(date);
    return day;
  }

  String roomInfo(EscapeRoom room, InfoType type) {
    List<String> resDate = getCalculateDay(room).split('/');
    int day = int.parse(resDate[1]);
    int month = int.parse(resDate[0]);
    List<String> otherTypeResDate = room.etc.split('/');
    switch(type){
      case InfoType.list:
        return listTypeInfo(room, day, month, otherTypeResDate);
      case InfoType.bookmark:
        return bookmarkTypeInfo(room, day, month, otherTypeResDate);
      case InfoType.dialog:
        return "미구현";
    }
  }

  String listTypeInfo(EscapeRoom room, int day, int month, List<String> otherTypeResDay){
    if(room.day == 0){
      return "${room.name}\n${otherTypeResDay[1]} 예약 - ${otherTypeResDay[0]}";
    }
    return "${room.name}\n$month월 $day일 예약 - 금일 ${room.etc}";
  }

  String bookmarkTypeInfo(EscapeRoom room, int day, int month, List<String> otherTypeResDay){
    if(room.day == 0) {
      return "${room.name}의\n${otherTypeResDay[1]}예약은\n${otherTypeResDay[0]}입니다.";
    }
    return "${room.name}의\n$month월 $day일 예약은\n금일 ${room.etc} 입니다.";
  }
}