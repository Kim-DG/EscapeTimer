class EscapeRoom {
  final int id;
  final String name;
  final String region;
  final String sub_region;
  int prefer;
  final int day;
  final String etc;
  int top_placement;

  EscapeRoom(
      {required this.id,
      required this.name,
      required this.region,
      required this.sub_region,
      required this.prefer,
      required this.day,
      required this.etc,
      required this.top_placement});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'region': region,
        'sub_region': sub_region,
        'prefer': prefer,
        'day': day,
        'etc': etc,
        'top_placement': top_placement,
   };

  String showName() {
    return name;
  }

  int calculateDay(int today){
    if(etc == "자정"){
      return today+day+1;
    }
    return today+day;
  }

  String topPlacementShowTime(int today) {
    int reservationTime = calculateDay(today);
    if (day == 0){
      List<String> time = etc.split('/');
      return "$name의 ${time[1]}예약이 ${time[0]}에 열립니다.";
    }
    return "$name의 $reservationTime일 예약이 오늘 $etc에 열립니다.";
  }
}


