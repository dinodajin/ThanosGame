import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(ThanosApp());
}

// StatelessWidget을 상속 받습니다.
class ThanosApp extends StatefulWidget {
  @override
  State<ThanosApp> createState() => _ThanosAppState();
}

class _ThanosAppState extends State<ThanosApp> {
  bool _showThanos = false;
  bool _fingerSnapOngoing = false;
  bool _showTimer = false;

  // _names 변수를 만들어줍니다.
  List<String> _names = [
    "김지연",
    "신하경",
    "박영서",
    "김서현",
    "김정섭",
    "이성찬",
    "민희원",
    "장민서",
    "전예린",
    "진선명",
    "이창윤",
    "정은정",
    "송정민",
    "이가현",
    "이예진",
    "김현태",
    "이승현",
    "김주원",
    "정연우",
    "김민성",
    "정다진",
    "이지연",
    "배기옥",
    "신찬희"
  ];

  // build 메소드를 구현합니다. ThanosApp에서 보여질 위젯들을 return에 넣어줍니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("타노스 게임"),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildGridView(),
              if (_showThanos)
                Center(
                  child: Image.asset("assets/thanos_snap.gif"),
                ),
              if (_showTimer)
                Countdown(
                  seconds: 5,
                  build: (context, second) {
                    return Text(
                      second.toString(),
                      style:
                          TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                    );
                  },
                  onFinished: () async {
                    // 타이머가 다 끝나면, 타노스 움짤을 보여준다.
                    if (_fingerSnapOngoing) {
                      return;
                    } else {
                      _fingerSnapOngoing = true;
                    }
                    if (_names.length <= 1) {
                      return;
                    }
                    setState(() {
                      _showThanos = true;
                    });

                    await Future.delayed(Duration(milliseconds: 3500));

                    setState(() {
                      _showThanos = false;
                    });
                  },
                ),
              Container(
                  margin: EdgeInsets.all(20).copyWith(bottom: 100), // 외부 여백
                  // padding: ,  // 내부 여백
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, -3)),
                    ],
                  ),
                  child: TextField(
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          _names.add(text); // 리스트에 이름 추가
                        });
                      }
                    },
                  )),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton()),
    );
  }

  Widget _buildGridView() {
    return GridView(
      padding: EdgeInsets.all(10),

      // GridView의 모양을 설정할 수 있습니다.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 세로 줄의 갯수를 정해줍니다.
        crossAxisCount: 3, // 3줄

        // 각 카드의 크기를 설정해줍니다.
        childAspectRatio: 1.5, // 가로세로 1.5 : 1 비율

        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),

      // 바둑판에 들어갈 각각의 카드 위젯을 넣는 곳입니다.
      children: [
        for (var name in _names)
          NameCard(
              name: name,
              onDelete: () {
                // setState를 통해 상태가 변했음을 알려줍니다.
                setState(() {
                  _names.remove(name);
                });
              }),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.teal,
      child: Image.asset("assets/finger_snap.png", width: 40, height: 40),
      onPressed: _onPressedFloatingActionButton,
    );
  }

  Future<void> _onPressedFloatingActionButton() async {
    _showTimer = true;
    if (_fingerSnapOngoing) {
      return;
    } else {
      _fingerSnapOngoing = true;
    }
    if (_names.length <= 1) {
      return;
    }
    setState(() {
      _showThanos = true;
    });

    await Future.delayed(Duration(milliseconds: 3500));

    setState(() {
      _showThanos = false;
    });

    setState(() {
      _names.shuffle();
      final half = _names.length ~/ 2;
      _names = _names.take(half).toList();
    });
    _fingerSnapOngoing = false;

    setState(() {
      _showTimer = false;
    });
  }
}

class NameCard extends StatelessWidget {
  final String name;
  final Function() onDelete;

  const NameCard({
    super.key,
    required this.name,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
