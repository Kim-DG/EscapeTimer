class EscapeRoom{
  final int id;
  final String name;

  EscapeRoom({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
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