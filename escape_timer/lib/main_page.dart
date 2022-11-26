import 'package:escape_timer/Model/escaperoom_model.dart';
import 'package:escape_timer/bloc/main_bloc.dart';
import 'package:escape_timer/info_type.dart';
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
          //bookMark(),
          const SizedBox(height: 10.0,),
          regionBar(),
          const SizedBox(height: 10.0,),
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
        mainBloc.roomInfo(mainBloc.filterListRoom[0],InfoType.bookmark),
        style: Theme.of(context).textTheme.bodyText1,
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
    final mainBloc = Provider.of<MainBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              mainBloc.filteringListRoom("강남");
            },
            child: Text(
              "강남",
              style: Theme.of(context).textTheme.bodyText2,
            )),
        TextButton(
            onPressed: () {
              mainBloc.filteringListRoom("홍대, 신촌");
            },
            child: Text(
              "홍대, 신촌",
              style: Theme.of(context).textTheme.bodyText2,
            )),
        TextButton(
            onPressed: () {
              mainBloc.filteringListRoom("그 외 서울");
            },
            child: Text(
              "그 외 서울",
              style: Theme.of(context).textTheme.bodyText2,
            )),
        TextButton(
            onPressed: () {
              mainBloc.filteringListRoom("수도권");
            },
            child: Text(
              "수도권",
              style: Theme.of(context).textTheme.bodyText2,
            )),
      ],
    );
  }


  escapeRoomList() {
    final mainBloc = Provider.of<MainBloc>(context);
    return Expanded(
      child: ListView.builder(
          itemCount: mainBloc.filterListRoom.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(12.0,0.0,12.0,12.0),
                child: borderContainer(escapeRoom(mainBloc.filterListRoom[index]),
                    Theme.of(context).primaryColor, 12.0));
          }),
    );
  }

  escapeRoom(EscapeRoom room) {
    final mainBloc = Provider.of<MainBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mainBloc.roomInfo(room,InfoType.list),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Icon(Icons.favorite_border_rounded),
      ],
    );
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
