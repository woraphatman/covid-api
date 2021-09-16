import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class Case extends StatelessWidget {
  const Case({
    Key? key,
    required this.size,
    required this.today,
    required this.count,
    required this.countAll,
  }) : super(key: key);

  final Size size;
  final bool today;
  final int count;
  final int countAll;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 130,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.lightBlue[800],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/covid-test.png', width: 170),
              SizedBox(
                child: Text(
                  today ? 'พบผู้ติดเชื้อวันนี้' : 'พบผู้ติดเชื้อทั้งหมด',
                  style: GoogleFonts.mali(
                    textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        letterSpacing: .5),
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
                        fontSize: 45,
                        letterSpacing: .5),
                  ),
                ),
              ),
              Text("คน",
                  style: GoogleFonts.mali(
                    textStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 30,
                        letterSpacing: .5),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
