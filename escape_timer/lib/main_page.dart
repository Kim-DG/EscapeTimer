import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    final mainBloc = Provider.of<MainBloc>(context, listen: false);
    mainBloc.getList();
  }

  BannerAd banner = BannerAd(
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdLoaded: (_) {},
    ),
    adUnitId: "ca-app-pub-3403461397972740/2738190500",
    request: const AdRequest(),
    size: AdSize.banner,
  )..load();

  @override
  void dispose() {
    super.dispose();
    banner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(
            height: 50,
            child: AdWidget(
              ad: banner,
            )
          ),
          const SizedBox(
            height: 32.0,
          ),
          bookMark(),
          const SizedBox(
            height: 10.0,
          ),
          regionBar(),
          const SizedBox(
            height: 10.0,
          ),
          escapeRoomList()
        ]),
      ),
    );
  }

  bookMark() {
    final mainBloc = Provider.of<MainBloc>(context);
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0),
            child: Text(
              mainBloc.bookmarkTypeInfo(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            constraints: const BoxConstraints(),
            icon: mainBloc.filterFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.orange,
                    size: 32,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.orange,
                    size: 32,
                  ),
            onPressed: () {
              mainBloc.filteringFavorite();
            },
          ),
        )
      ],
    );
  }

  regionBar() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: borderContainer(
                regionList(), Theme.of(context).secondaryHeaderColor, 0.0)),
      ],
    );
  }

  regionList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        regionListTextButton("강남"),
        regionListTextButton("홍대, 신촌"),
        regionListTextButton("그 외 서울"),
        regionListTextButton("수도권")
      ],
    );
  }

  regionListTextButton(String region) {
    final mainBloc = Provider.of<MainBloc>(context);
    return TextButton(
        onPressed: () {
          mainBloc.filteringListRoom(region);
        },
        child: Text(
          region,
          style: Theme.of(context).textTheme.bodyText2,
        ));
  }

  escapeRoomList() {
    final mainBloc = Provider.of<MainBloc>(context);
    return Expanded(
      child: ListView.builder(
          itemCount: mainBloc.filterListRoom.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                child: borderContainer(
                    escapeRoom(mainBloc.filterListRoom[index]),
                    Theme.of(context).primaryColor,
                    8.0));
          }),
    );
  }

  escapeRoom(EscapeRoom room) {
    final mainBloc = Provider.of<MainBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextButton(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                mainBloc.listTypeInfo(room),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            onPressed: () {
              roomInfoDialog(room);
            },
          ),
        ),
        IconButton(
            icon: Icon(Icons.calendar_month, color: Colors.orange),
            onPressed: () {
              calendarDialog(room);
            }),
        Column(
          children: [
            IconButton(
                icon: room.prefer == 0
                    ? const Icon(Icons.favorite_border_rounded,
                        color: Colors.orange)
                    : const Icon(Icons.favorite_rounded, color: Colors.orange),
                onPressed: () {
                  mainBloc.setPrefer(room);
                }),
          ],
        )
      ],
    );
  }

  roomInfoDialog(EscapeRoom room) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: borderContainer(
                  roomInfoDetail(room), Theme.of(context).primaryColor, 12.0));
        });
  }

  roomInfoDetail(EscapeRoom room) {
    final mainBloc = Provider.of<MainBloc>(context);

    return StatefulBuilder(builder: (__, StateSetter setState) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText1!,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("테마이름: ${room.name}"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "오픈날짜: ${room.day != 0 ? mainBloc.getNormalTypeOpen(room) : mainBloc.getOtherTypeOpen(room, 1)}"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "오픈시간: ${room.day != 0 ? room.etc : mainBloc.getOtherTypeOpen(room, 0)}"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("지역: ${room.region} / ${room.sub_region}"),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: IconButton(
                        icon: room.prefer == 0
                            ? const Icon(Icons.favorite_border_rounded,
                                color: Colors.orange)
                            : const Icon(Icons.favorite_rounded,
                                color: Colors.orange),
                        onPressed: () {
                          setState(() {
                            mainBloc.setPrefer(room);
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: room.top_placement == 0
                            ? Icon(Icons.star_border, color: Colors.orange)
                            : Icon(Icons.star, color: Colors.orange),
                        onPressed: () {
                          setState(() {
                            mainBloc.setTopPlacement(room);
                          });
                        }),
                  ),
                ],
              )
            ]),
      );
    });
  }

  calendarDialog(EscapeRoom room) {
    final mainBloc = Provider.of<MainBloc>(context, listen: false);
    DateTime focused = DateTime.now();
    DateTime selected = DateTime.now();
    String reservationTime = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: StatefulBuilder(builder: (__, StateSetter setState) {
                return borderContainer(
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(room.name,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor)),
                        TableCalendar(
                          locale: 'ko_KR',
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: focused,
                          onDaySelected:
                              (DateTime selectedDay, DateTime focusedDay) {
                            setState(() {
                              selected = selectedDay;
                              focused = focusedDay;
                              reservationTime = mainBloc.getCalendarTime(room, selectedDay);
                            });
                          },
                          selectedDayPredicate: (DateTime day) {
                            return isSameDay(selected, day);
                          },
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                          calendarStyle: CalendarStyle(
                            selectedTextStyle: const TextStyle(
                              color: Color(0xFFFAFAFA),
                              fontSize: 16.0,
                            ),
                            selectedDecoration: const BoxDecoration(
                              color: Color(0xFF5C6BC0),
                              shape: BoxShape.circle,
                            ),
                            outsideTextStyle: TextStyle(
                                color:
                                Theme.of(context).scaffoldBackgroundColor),
                            weekendTextStyle: const TextStyle(color: Colors.blue),
                            defaultTextStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("오픈 예약 시간:\n$reservationTime",
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor)),
                        )
                      ],
                    ),
                    Theme.of(context).primaryColor,
                    12.0);
              }));
        });
  }

  borderContainer(Widget w, Color c, double padding) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: c,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(2, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(padding),
        child: w); //테두리
  }
}
