import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'quotes_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(key: key);

  Future<List<dynamic>> fetchBbCharacters() async {
    var idx = 0;
    final res = await http.get(Uri.parse('https://www.breakingbadapi.com/api/characters'), );
    var json = jsonDecode(res.body);
    List<dynamic> chars = [];
    for (; idx < json.length; idx++) {
      chars.add(json[idx]);
    }
    return chars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breaking Bad Quotes"),
      ),
      body: FutureBuilder(
        future: fetchBbCharacters(),
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
                return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () { Navigator.push(context, MaterialPageRoute(
                                builder: (context) => QuotesScreen(
                                    id: snapshot.data[index]["char_id"],
                                    name: snapshot.data[index]["name"])));
                      },
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data[index]["img"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft, // align author names
                          child: Text(
                            '${snapshot.data[index]["name"]}',
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          }  else {
             throw('Error');
          }
        },
      ),
    );
  }
}