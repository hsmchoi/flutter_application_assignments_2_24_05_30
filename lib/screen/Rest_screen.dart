import 'package:flutter/material.dart';

import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  // ignore: non_constant_identifier_names
  int TotalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  late Timer timer;
  // ignore: non_constant_identifier_names
  int TotalPomodors = 0;
  int round = 0;
  int roundLimit = 4;
  int goalLimit = 12;
  int goal = 0;

  void onTick(Timer timer) {
    if (TotalSeconds == 0) {
      setState(() {
        onRestartPress();
        TotalPomodors = TotalPomodors + 1;
        round = round + 1;
        if (round == roundLimit) {
          round = 0;
          goal = goal + 1;
          timer.cancel();
        }
        if (goal == goalLimit) {
          timer.cancel();
        }
      });
    } else {
      setState(() {
        TotalSeconds = TotalSeconds - 1;
      });
    }
  }

  void count(int count) {
    count = 0;
    if (TotalPomodors == 0) {
      setState(() {
        count = count + 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePress() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPress() {
    TotalSeconds = twentyFiveMinutes;
    setState(() {
      isRunning = false;
      TotalPomodors = 0;
      timer.cancel();
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    String durationValue = duration.toString().split(".").first.substring(2, 7);
    return durationValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Flexible(
              //POMOTIMER 글자
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  // Column의 남은 공간을 Stack이 차지하도록 Expanded 사용
                  child: Stack(
                    alignment: Alignment.center,
                    // Stack 내부 요소 가운데 정렬
                    children: [
                      Container(
                        // 배경 컨테이너
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor, // 배경 색상 설정
                          borderRadius: BorderRadius.circular(15), // 둥근 모서리 설정
                        ),
                      ),
                      Positioned(
                        // 왼쪽 숫자 박스
                        left: 110,
                        top: 66,
                        child: Container(
                          width: 60,
                          height: 95,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5)),

                          child: Center(
                              child: Text(
                                  format(TotalSeconds).split(":")[0])), // : 표시
                        ),
                      ),
                      Positioned(
                        // 왼쪽 숫자 박스
                        left: 100,
                        top: 75,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5)),

                          child: Center(
                              child: Text(
                                  format(TotalSeconds).split(":")[0])), // : 표시
                        ),
                      ),
                      Positioned(
                        // 왼쪽 숫자 박스
                        left: 105,
                        top: 70,
                        child: Container(
                          width: 70,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(0.5)), // : 표시
                        ),
                      ),
                      Positioned(
                        // 왼쪽 숫자 박스
                        left: 100,
                        top: 80,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(1)),

                          child: Center(
                              child: Text(
                            format(TotalSeconds).split(":")[0],
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w700),
                          )), // : 표시
                        ),
                      ),
                      Positioned(
                        // 콜론(:)
                        top: 100, // 콜론 위치 조절
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 45,
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
                        // 잔상
                        right: 110,
                        top: 66,
                        child: Container(
                          width: 60,
                          height: 95,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
                        // 잔상
                        right: 100,
                        top: 75,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
                        // 잔상효과
                        right: 105,
                        top: 70,
                        child: Container(
                          width: 70,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
                        // 오른쪽 숫자 박스
                        right: 100,
                        top: 80,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Center(
                              child: Text(
                            format(TotalSeconds).split(":")[1],
                            style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w700),
                          )), // 초 표시
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            //시간 설정
            flex: 1,
            child: Stack(
              children: [
                Positioned(
                    child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var duration in [15, 20, 25, 30, 35])
                          TextButton(
                            onPressed: () {
                              setState(() {
                                TotalSeconds = duration * 60;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(duration.toString()),
                          ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 20,
                  child: Center(
                    child: IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: onRestartPress,
                      icon: const Icon(Icons.restart_alt),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: Center(
                    child: IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onPausePress : onStartPressed,
                      icon: Icon(
                        isRunning
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                Positioned(
                  // Stack 안에서 위치 지정
                  left: 80,
                  top: 20,
                  child: Center(
                    child: Text(
                      '$round/$roundLimit',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                // 파란색 배경
                const Positioned(
                  // Stack 안에서 위치 지정
                  left: 70,
                  top: 55,
                  child: Center(
                    child: Text(
                      'ROUND',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // Stack 안에서 위치 지정
                  right: 80,
                  top: 20,
                  child: Center(
                    child: Text(
                      '$goal/$goalLimit',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  // Stack 안에서 위치 지정
                  right: 85,
                  top: 55,
                  child: Center(
                    child: Text(
                      'GOAL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
