import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/repository/main_repository.dart';
import 'package:flutter/cupertino.dart';

class MainBloc extends ChangeNotifier{
  final MainRepository _mainRepository = MainRepository();
  late List<EscapeRoom> listRoom;

  Future<List<EscapeRoom>> getList() async {
    listRoom = await _mainRepository.getAllRooms();
    return listRoom;
  }
}