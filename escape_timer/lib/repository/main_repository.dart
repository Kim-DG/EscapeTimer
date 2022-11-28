import 'package:escape_timer/DB/database_provider.dart';

import '../Model/escaperoom_model.dart';

class MainRepository{
  static final MainRepository _mainRepository = MainRepository._internal();
  factory MainRepository() => _mainRepository;
  late DatabaseProvider databaseProvider;

  MainRepository._internal(){
    databaseProvider = DatabaseProvider();
  }

   Future<List<EscapeRoom>> getAllRooms() async {
      return await databaseProvider.getAllRooms();
    }

   Future roomUpdate(EscapeRoom room) async{
     await databaseProvider.roomUpdate(room);
   }
}