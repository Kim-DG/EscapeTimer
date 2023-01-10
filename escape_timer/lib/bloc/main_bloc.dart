import 'dart:math';

import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class MainBloc extends ChangeNotifier{
  MainBloc(){
    _mainRepository = MainRepository();
  }
  late MainRepository _mainRepository;
  EscapeRoom _bookmarkRoom = EscapeRoom(id: -1, name: "dummy", region: "dummy", sub_region: "dummy", prefer: 0, day: 0, etc: "dummy", top_placement: 0);
  EscapeRoom get bookmarkRoom => _bookmarkRoom;

  bool _filterFavorite = false;
  bool get filterFavorite => _filterFavorite;

  String _currentRegion = "강남";
  String get currentRegion => _currentRegion;

  List<EscapeRoom> _allListRoom = List.empty();
  List<EscapeRoom> get allListRoom => _allListRoom;

  List<EscapeRoom> _filterListRoom = List.empty();
  List<EscapeRoom> get filterListRoom => _filterListRoom;

  Future<List<EscapeRoom>> getList() async {
    if(allListRoom.isEmpty) {
      _allListRoom = await _mainRepository.getAllRooms();
      _filterListRoom = allListRoom;
      setBookmark();
      notifyListeners();
    }
    return allListRoom;
  }

  void filteringListRoom(String region){
    _currentRegion = region;
    _filterListRoom = allListRoom.where((e) => e.region == currentRegion).toList();
    if(_filterFavorite){
      _filterListRoom = _filterListRoom.where((e) => e.prefer == 1).toList();
    }
    notifyListeners();
  }

  void filteringFavorite(){
    _filterFavorite = !_filterFavorite;
    if(_filterFavorite){
      _filterListRoom = _filterListRoom.where((e) => e.prefer == 1).toList();
    }
    else{
      _filterListRoom = allListRoom.where((e) => e.region == currentRegion).toList();
    }
    notifyListeners();
  }

  void setBookmark(){
    var searchBookmark = allListRoom.where((e) => e.top_placement == 1).toList();
    if(searchBookmark.isNotEmpty){
      _bookmarkRoom = searchBookmark[0];
    }
    else{
      _bookmarkRoom = _allListRoom[Random().nextInt(_allListRoom.length)];
    }
  }

  void setPrefer(EscapeRoom room){
    room.prefer == 0 ? room.prefer = 1 : room.prefer = 0;
    _mainRepository.roomUpdate(room);
    notifyListeners();
  }

  void setTopPlacement(EscapeRoom room){
    room.top_placement == 0 ? room.top_placement = 1 : room.top_placement = 0;
    _mainRepository.roomUpdate(room);
    _bookmarkRoom.top_placement = 0;
    _mainRepository.roomUpdate(_bookmarkRoom);
    _bookmarkRoom = room;
    notifyListeners();
  }

  String getCalendarTime(EscapeRoom room, DateTime date){
    if (room.etc == "자정") date = date.subtract(const Duration(days: 1));
    date = date.subtract(Duration(days: room.day));
    var resDate = DateFormat('MM/dd').format(date).split('/');
    int day = int.parse(resDate[1]);
    int month = int.parse(resDate[0]);
    return "$month월 $day일 ${room.etc}";
  }

  String getCalculateDay(EscapeRoom room){
    var date = DateTime.now().add(Duration(days:room.day));
    if (room.etc == "자정") date = date.add(const Duration(days: 1));
    var day = DateFormat('MM/dd').format(date);
    return day;
  }

  String getNormalTypeOpen(EscapeRoom room){
    List<String> resDate = getCalculateDay(room).split('/');
    int day = int.parse(resDate[1]);
    int month = int.parse(resDate[0]);
    return "$month월 $day일";
  }

  String getOtherTypeOpen(EscapeRoom room, int i){
    List<String> otherTypeResDate = room.etc.split('/');
    return otherTypeResDate[i];
  }

  String listTypeInfo(EscapeRoom room) {
    if(room.day == 0) return "${room.name}\n${getOtherTypeOpen(room, 1)} 예약:\n${getOtherTypeOpen(room, 0)}";
    return "${room.name}\n${getNormalTypeOpen(room)} 예약:\n오늘 ${room.etc}";
  }

  String bookmarkTypeInfo(){
    if(_bookmarkRoom.id == -1) return("");
    if(_bookmarkRoom.day == 0) return "${_bookmarkRoom.name}의\n${getOtherTypeOpen(_bookmarkRoom, 1)}예약은\n${getOtherTypeOpen(_bookmarkRoom, 0)}입니다";
    return "${_bookmarkRoom.name}의\n${getNormalTypeOpen(_bookmarkRoom)} 예약은\n오늘 ${bookmarkRoom.etc} 입니다";
  }
}