import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flatlist_scroll/flatlist_scroll.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartApp(),
    );
  }
}

class StartApp extends StatefulWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  List<Content> data = [];
  Future<List<Content>?> fetchData(int page) async {
    String url =
        "https://jsonplaceholder.typicode.com/posts?_limit=10&_page=$page";
    print(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = (json.decode(response.body) as List)
          .map((e) => Content.fromJson(e))
          .toList();
      return data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flatlist Scroll")),
      body: FlatlistScroll(
        controller: ScrollController(),
        data: data,
        // Note updated use for state management only.
        // updated: (val) {
        //   if you use state manage with provider or getx. You need update state here
        //   // Ex: For Provider
        //   //context.read<ContentController>().data = val!.cast<Content>();
        //   //context.read<ContentController>().notifyListeners();
        //   // Ex: For Getx
        //   //ctl.data = val!.cast<Content>();
        //   //ctl.update();
        // },
        onLoadMore: fetchData,
        renderItem: (item) => _buildItem(item),
        onLoadMoreThreshold: 300,
      ),
    );
  }

  Widget _buildItem(Content item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.body),
    );
  }
}

class Content {
  final int userId;
  final int id;
  final String title;
  final String body;

  Content({this.userId = 0, this.id = 0, this.title = "", this.body = ""});
  factory Content.fromJson(Map<String, dynamic> map) {
    return Content(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }
}
