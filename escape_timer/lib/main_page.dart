import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16.0, 96.0, 16.0, 32.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0),
      child: Text(
        mainBloc.bookmarkTypeInfo(),
        style: Theme.of(context).textTheme.headline1,
      ),
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
                    12.0));
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
            icon: room.prefer == 0
                ? const Icon(Icons.favorite_border_rounded, color: Colors.orange)
                : const Icon(Icons.favorite_rounded, color: Colors.orange),
            onPressed: () {
              mainBloc.setPrefer(room);
            })
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
              Padding(padding: const EdgeInsets.all(16.0),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("테마이름: ${room.name}"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "오픈날짜: ${room.day != 0 ? mainBloc.getNormalTypeOpen(room) : mainBloc.getOtherTypeOpen(room, 1)}"
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "오픈시간: ${room.day != 0 ? "금일 ${room.etc}" : mainBloc.getOtherTypeOpen(room, 0)}"
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "지역: ${room.region} / ${room.sub_region}"
                  ),
                ],
              ),),


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
