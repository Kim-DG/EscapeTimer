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

  String getRegion(){
    return region;
  }

  int getPrefer(){
    return prefer;
  }

  int getTopPlacement(){
    return top_placement;
  }
}


