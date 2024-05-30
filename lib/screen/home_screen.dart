import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: PomodoroTimer()));
}

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const twentyFiveMinutes = 1500;
  static const fiveMinutes = 300;

  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  Timer? timer;
  int completedPomodoros = 0;
  int round = 1;
  int roundLimit = 4;
  int goalLimit = 12;
  int goal = 0;
  int selectedSeconds = twentyFiveMinutes;
  bool needResting = false;

  @override
  void initState() {
    super.initState();
    _resetTimer(); // 타이머 초기화
  }

  @override
  void dispose() {
    timer?.cancel(); // 위젯 종료 시 타이머 해제
    super.dispose();
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      if (needResting) {
        completedPomodoros++;
        round = round == roundLimit ? 1 : round + 1; // 라운드 증가 및 초기화

        if (round == 1) {
          goal++;
          if (goal == goalLimit) {
            timer.cancel();
            _showAlertDialog('뽀모도로 완료!', '목표를 모두 달성했습니다!');
            return;
          }
        }

        needResting = false;
        totalSeconds = selectedSeconds;
      } else {
        needResting = true;
        totalSeconds = fiveMinutes; // 5분 휴식 (300초)
      }

      _startTimer(); // 다음 타이머 시작 (작업 또는 휴식)
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    if (!isRunning) {
      _startTimer();
      setState(() {
        isRunning = true;
      });
    }
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1), onTick);
  }

  void onPausePress() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPress() {
    _resetTimer();
  }

  void _resetTimer() {
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
      completedPomodoros = 0;
      round = 1; // 초기 라운드는 1로 설정
      goal = 0;
    });
    timer?.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: needResting ? Colors.green : Theme.of(context).hintColor,
      body: Column(
        children: [
          // ... (POMOTIMER 텍스트 위젯)

          Flexible(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 66,
                        child: Container(
                          width: 60,
                          height: 95,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                          child: Center(
                              child: Text(format(totalSeconds).split(":")[0])),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 75,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                          child: Center(
                              child: Text(format(totalSeconds).split(":")[0])),
                        ),
                      ),
                      Positioned(
                        left: 105,
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
                        left: 100,
                        top: 80,
                        child: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(1),
                          ),
                          child: Center(
                            child: Text(
                              format(totalSeconds).split(":")[0],
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontSize: 45,
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
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
                              format(totalSeconds).split(":")[1],
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ... (시간 설정, 컨트롤 버튼, 라운드 정보 위젯)
        ],
      ),
    );
  }
}
