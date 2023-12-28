import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:catfactapi/catfactapi.dart';

class Catfact extends StatefulWidget {
  const Catfact({super.key});



  @override
  State<Catfact> createState() => _CatfactState();

  // static Future<catfact> fromjson(jsonDecode) {}
}

class _CatfactState extends State<Catfact> {


  Future<catfact> FetchCatdetails() async{
    var resp=await http.get(Uri.parse("https://catfact.ninja/fact"));
    return catfact.fromJson(jsonDecode(resp.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<catfact>(
            future: FetchCatdetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return
                  Column(
                    children: [
                      Text(snapshot.data!.fact.toString()),
                      Text(snapshot.data!.length.toString()),



                    ],
                  );

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),

    );
  }
}
