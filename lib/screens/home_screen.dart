import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToonFlex',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Column(
                children: [
                  const SizedBox(height: 60),
                  Expanded(
                    child: webtoonList(data),
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView webtoonList(List<WebtoonModel> data) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        var webtoon = data[index];
        return Column(
          children: [
            Image.network(
              webtoon.thumb,
            ),
            Text(webtoon.title)
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 36,
      ),
      // children: [for (var webtoon in data) Text(webtoon.title)],
    );
  }
}
