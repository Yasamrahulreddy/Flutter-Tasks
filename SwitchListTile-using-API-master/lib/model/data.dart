import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data {
  final String text;
  final String author;

  Data({this.text, this.author});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      text: json['text'],
      author: json['author'],
    );
  }
}

class DataListView extends StatefulWidget {
  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  bool _flutter = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: _fetchdata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Data> data = snapshot.data;
          return _dataListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Data>> _fetchdata() async {
    final jobsListAPIUrl =
        'http://www.json-generator.com/api/json/get/cfYPmeBtBu?indent=2';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Data.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _dataListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(data[index].text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            subtitle: Text(data[index].author,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
            value: _flutter,
            onChanged: (bool value) {
              setState(() {
                _flutter = value;
              });
            },
          );
        });
  }
}
