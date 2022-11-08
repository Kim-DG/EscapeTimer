class EscapeRoom{
  final int id;
  final String name;
  final String region;
  final String sub_region;
  final int prefer;
  final int day;
  final int hour;
  final int second;
  final String etc;


  EscapeRoom({
    required this.id,
    required this.name,
    required this.region,
    required this.sub_region,
    required this.prefer,
    required this.day,
    required this.hour,
    required this.second,
    required this.etc
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'region' : region,
    'sub_region' : sub_region,
    'prefer' : prefer,
    'day' : day,
    'hour' : hour,
    'second' : second,
    'etc' : etc,
  };
}

/*
bool prefer;
int openTimeDay;
int openTimeHour;
int openTimeSecond;

EscapeRoom({
  required this.id,
  required this.name,
  required this.prefer,
  required this.openTimeDay,
  required this.openTimeHour,
  required this.openTimeSecond
});

factory EscapeRoom.fromJson(Map<String, dynamic> json) => EscapeRoom(
id: json["id"],
name: json["name"],
prefer: json["prefer"],
openTimeDay: json["openTimeDay"],
openTimeHour: json["openTimeHour"],
openTimeSecond: json["openTimeSecond"]
);

Map<String, dynamic> toMap() => {
  "id": id,
  "name": name,
  "prefer": prefer,
  "openTimeDay": openTimeDay,
  "openTimeHour": openTimeHour,
  "openTimeSecond": openTimeSecond
};

 */