// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class GoHome extends StatelessWidget {
  const GoHome({
    Key? key,
    required this.today,
    required this.count,
    required this.countAll,
    required this.size,
  }) : super(key: key);
  final bool today;
  final int count;
  final int countAll;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/home.png', width: 170),
            SizedBox(
              child: Text(
                today ? 'รักษาหายวันนี้' : 'รักษาหายทั้งหมด',
                style: GoogleFonts.mali(
                  textStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 20, letterSpacing: .5),
                ),
              ),
            ),
            SizedBox(
              child: Text(
                intl.NumberFormat.decimalPattern()
                    .format(today ? count : countAll),
                style: GoogleFonts.mali(
                  textStyle: const TextStyle(
                      color: Color(0xff1B1E63),
                      fontSize: 40,
                      letterSpacing: .5),
                ),
              ),
            ),
            Text("คน",
                style: GoogleFonts.mali(
                  textStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 30, letterSpacing: .5),
                ))
          ],
        ),
      ),
    );
  }
}
