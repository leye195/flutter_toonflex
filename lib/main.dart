import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

// state
class _AppState extends State<App> {
  int counter = 0;
  List<int> numbers = [];
  bool showTitle = true;

  void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }

  void onToggle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: const TextTheme(
                titleLarge: TextStyle(color: Colors.red))), // visual properties
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Click Count',
                    style: TextStyle(
                      fontSize: 32,
                    )),
                for (var n in numbers) Text('$n'),
                IconButton(
                    iconSize: 40,
                    onPressed: onClicked,
                    icon: const Icon(
                      Icons.add_box_rounded,
                    )),
                showTitle ? const LargeTitle() : const Text('Nothing here'),
                IconButton(
                    onPressed: onToggle, icon: const Icon(Icons.remove_red_eye))
              ],
            ),
          ),
        ));
  }
}

class LargeTitle extends StatefulWidget {
  const LargeTitle({
    super.key,
  });

  @override
  State<LargeTitle> createState() => _LargeTitleState();
}

class _LargeTitleState extends State<LargeTitle> {
  @override
  void initState() {
    // 부모 요소에 의존하는 데이터를 초기화 해야하는 경우
    super.initState();
    print('initState here');
  }

  @override
  Widget build(BuildContext context) {
    print('build here');
    return Text('Large Title',
        style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).textTheme.titleLarge?.color));
  }

  @override
  void dispose() {
    // 위젯이 스크린에서 제거될 때 호출
    super.dispose();
    print('dispose here');
  }
}
