// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:covid/ui/case.dart';

import 'package:covid/ui/death.dart';
import 'package:covid/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-Thailand',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool today = true;

  void changeType(type) {
    setState(() {
      today = type;
    });
  }

  Map<String, dynamic> covidData = {};

  @override
  void initState() {
    super.initState();
    fetchCovidData();
  }

  Future fetchCovidData() async {
    var response = await http.get(
        Uri.parse("https://static.easysunday.com/covid-19/getTodayCases.json"));
    if (response.statusCode == 200) {
      setState(() {
        covidData = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (covidData["country"] == null) {
      return Scaffold(
        body: Center(child: Text("{Law Pap Na}")),
      );
    }
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/originals/5b/83/00/5b83002ed8197fe2990bef6d03369950.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(
                height: 20,
              ),
              selectionCase(size),
              SizedBox(
                height: 20,
              ),
              Case(
                size: size,
                count: covidData["todayCases"],
                today: today,
                countAll: covidData["cases"],
              ),
              SizedBox(
                height: 20,
              ),
              Death(
                countAll: covidData["deaths"],
                today: today,
                count: covidData["todayDeaths"],
                size: size,
              ),
              SizedBox(
                height: 20,
              ),
              GoHome(
                countAll: covidData["recovered"],
                today: today,
                count: covidData["todayRecovered"],
                size: size,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/d.jpg',
                  ),
                ],
              ),
            ])),
          ),
        ));
  }

  Container selectionCase(Size size) {
    return Container(
      width: size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.deepPurple),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Center(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () => {changeType(true)},
                  child: Center(
                    child: Text(
                      'วันนี้',
                      style: GoogleFonts.mali(
                        textStyle: TextStyle(
                            color:
                                today ? Color(0xff1B1E63) : Color(0xff557CFF),
                            fontSize: 25,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () => {changeType(false)},
                  child: Center(
                    child: Text(
                      'ข้อมูล',
                      style: GoogleFonts.mali(
                        textStyle: TextStyle(
                            color:
                                !today ? Color(0xff1B1E63) : Color(0xff557CFF),
                            fontSize: 25,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
