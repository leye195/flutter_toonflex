import 'dart:async';

import 'package:flutter/material.dart';

const timeList = [1500, 300, 900];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalCount = 0;
  int totalSeconds = 1500;
  int activeIndex = 0;
  bool isRunning = false;

  late Timer timer;

  // date format
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2);
  }

  void onTimeout() {
    setState(() {
      totalCount += 1;
      totalSeconds = timeList[activeIndex];
      isRunning = false;
    });
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      onTimeout();
      timer.cancel();
      return;
    }

    setState(() {
      totalSeconds -= 1;
    });
  }

  dynamic onTabPress(int idx) {
    return () {
      setState(() {
        activeIndex = idx;
        onStopPress();
      });
    };
  }

  void onStartPress() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick); // set timer
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

  void onStopPress() {
    timer.cancel(); // cancel timer
    setState(() {
      totalSeconds = timeList[activeIndex];
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(color: Color(0x44ffffff)),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: onTabPress(0),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: activeIndex == 0
                                  ? const Color(0x00ffffff)
                                  : const Color(0x44ffffff),
                              textStyle: const TextStyle(fontSize: 20)),
                          child: const Text('Pomodoro'),
                        ),
                        ElevatedButton(
                            onPressed: onTabPress(1),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: activeIndex == 1
                                    ? const Color(0x00ffffff)
                                    : const Color(0x44ffffff),
                                textStyle: const TextStyle(fontSize: 20)),
                            child: const Text('Short Break')),
                        ElevatedButton(
                            onPressed: onTabPress(2),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: activeIndex == 2
                                    ? const Color(0x00ffffff)
                                    : const Color(0x44ffffff),
                                textStyle: const TextStyle(fontSize: 20)),
                            child: const Text('Long Break'))
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      format(totalSeconds),
                      style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 90,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )), // UI를 비율 기반으로 더 유연하게 만들어줌,
          Flexible(
              flex: 2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline),
                      iconSize: 100,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onPausePress : onStartPress,
                    ),
                    if (isRunning)
                      IconButton(
                        onPressed: onStopPress,
                        icon: const Icon(Icons.stop_circle_outlined),
                        iconSize: 100,
                        color: Theme.of(context).cardColor,
                      ),
                  ],
                ),
              )),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pomodoros',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color)),
                          const SizedBox(height: 4),
                          Text(
                            '$totalCount',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
