import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class QuotesScreen extends StatelessWidget {
  final String name;
  final int id;
  const QuotesScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  Future<List> fetchQuote(int id) async {
      var idx = 0;
      final res = await http.get(Uri.parse('https://breakingbadapi.com/api/quotes'), );
      var json = jsonDecode(res.body);
      List<String> phrase = [];
      for (; idx < json.length; idx++) {
        if (json[idx]["author"] == name) {
          phrase.add(json[idx]["quote"]);
        }
      }
      return phrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad Quotes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: FutureBuilder(
        future: fetchQuote(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return ListView.builder(padding: EdgeInsets.all(6), itemCount: snapshot.data.length, itemBuilder: (BuildContext context, int index) {
                  return Text(
                    '${snapshot.data[index]}',
                    style: TextStyle(
                        color: Colors.black,
                        height: 2.0,
                        letterSpacing: 0.3),
                  );
                },
              );
            }
          } else {
            throw('Error');
          }
        },
      ),
    );
  }
}