import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';

class MainBloc extends ChangeNotifier{
  MainBloc(){
    _mainRepository = MainRepository();
    setAllRooms();
  }
  late MainRepository _mainRepository;
  late List<EscapeRoom> listRoom;

  Future<List<EscapeRoom>> getList() async {
    return await _mainRepository.getAllRooms();
  }
  setAllRooms() async {
    listRoom = await getList();
    print("!!!!!!!!!!!!!"+listRoom[50].sub_region);
  }
}