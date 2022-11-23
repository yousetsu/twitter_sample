import 'package:flutter/material.dart';
//twitterアイコンを使用するため
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//ツイートするため
import 'package:url_launcher/url_launcher_string.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twitter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Twitter Demo Home Page'),
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

  //ツイートするメソッド
  void tweet() async {
    final Map<String, dynamic> tweetParameters = {
      "text": '1行目 test1\n2行目 test2',
      "url": 'https://computer.sarujincanon.com',
      "hashtags": 'test1,test2',
    };
    //URIスキームを使ってtwitterに接続
    final Uri tweetScheme =
    Uri(scheme: "twitter", host: "post", queryParameters: tweetParameters);

    //直接ブラウザからURLに接続
    final Uri tweetIntentUrl =
    Uri.https("twitter.com", "/intent/tweet", tweetParameters);

    //Twitter呼び出し
    await canLaunchUrlString(tweetScheme.toString())//アプリ起動できるか確認
        ? await launchUrlString(tweetScheme.toString())//アプリ起動
        : await launchUrlString(tweetIntentUrl.toString());//ブラウザ起動
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tweet();//ツイート
        },
        child: const Icon(MdiIcons.twitter),
      ),
    );
  }
}
