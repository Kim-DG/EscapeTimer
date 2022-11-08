import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DB/database_provider.dart';
import 'package:escape_timer/DB/database_provider.dart';

import 'bloc/main_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mainBloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: mainBloc.getList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                    }

                    //error가 발생하게 될 경우 반환하게 되는 부분
                    else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text(
                          'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }

                    // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                    else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text(
                          mainBloc.listRoom[index].name, // 비동기 처리를 통해 받은 데이터를 텍스트에 뿌려줌
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }
                  },
                );
              })),
    );
  }
}
