import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xrandom/xrandom.dart';

class WhoIsFast extends StatefulWidget {
  const WhoIsFast({super.key});

  @override
  State<WhoIsFast> createState() => _WhoIsFastState();
}

class _WhoIsFastState extends State<WhoIsFast> {
  final gapH20 = const SizedBox(height: 20);
  final gapW20 = const SizedBox(width: 20);
  String dogPic = '';
  String dogPic2 = '';
  bool d1 = false;
  bool d2 = false;
  getDog1() async {
    final dio = Dio();
    final response = await dio.get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      setState(() {
        dogPic = response.data['message'] as String;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  getDog2() async {
    final dio = Dio();
    final response = await dio.get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      setState(() {
        dogPic2 = response.data['message'] as String;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  double WH_200 = 200;
  TextStyle get resultTextStyle =>
      const TextStyle(fontSize: 20, color: Colors.green);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who is Fast?'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            gapH20,
            gapH20,
            const Text(
              'Who is Fast?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            gapH20,
            Row(
              children: [
                gapW20,
                if (!dogPic.isEmpty)
                  Expanded(
                      child:
                          Image.network(dogPic, width: WH_200, height: WH_200)),
                if (!dogPic2.isEmpty)
                  Expanded(
                      child: Image.network(dogPic2,
                          width: WH_200, height: WH_200)),
              ],
            ),
            gapH20,
            ElevatedButton(
              onPressed: () {
                final xrandom = Xrandom();
                int randomValue = xrandom.nextInt(5);
                if (randomValue > 2) {
                  d2 = true;
                  d1 = false;
                } else {
                  d1 = true;
                  d2 = false;
                }
                getDog1();
                getDog2();
              },
              child: Text('START'),
            ),
            gapH20,
            d1
                ? Text('Left Dog Run Fast!', style: resultTextStyle)
                : d2
                    ? Text('Right Dog Run Fast!', style: resultTextStyle)
                    : Text("Pending...", style: resultTextStyle),
            gapH20,
            Text("Result is random generated, its just for fun!",
                style: const TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
