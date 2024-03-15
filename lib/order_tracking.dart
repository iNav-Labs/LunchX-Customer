// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({super.key});

  @override
  _OrderTrackerState createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width - 20.0; // Full width of the card
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6552FE),
        elevation: 10, // Removes the shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: Text(
          'Order Tracking',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to the original main screen
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: 20,),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Bill',
                          style: GoogleFonts.outfit(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Almost zero platform fees applied.',
                          style: GoogleFonts.outfit(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6552FE),
                          ),
                        ),
                        SizedBox(height: 10.0), // Add some spacing

                        // Dynamically build containers based on order list
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Order Number',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  '#A0798',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Color(0xFF6552FE),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Shop / Canteen',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Apna Adda',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Receiver Name',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Anuj Patel',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),

// **************************************************************************************************
// SizedBox(height:20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ADD COOKING CARDS

            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 180,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF19D20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Order Status',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/pizza.gif', // Replace with the path to your logo image
                            width: 70, // Adjust the width as needed
                            height: 70, // Adjust the height as needed
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Cooking',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 180,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF6552FE),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Expected Time',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/alarm.gif', // Replace with the path to your logo image
                            width: 70, // Adjust the width as needed
                            height: 70, // Adjust the height as needed
                          ),
                          SizedBox(height: 10),
                          Text(
                            '10-12 min',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // END COOKING CARDS

            SizedBox(
              height: 40,
            ),
            Text.rich(
              TextSpan(
                text: 'Total ',
                style: GoogleFonts.outfit(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: '32 mins',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  TextSpan(
                    text: ' saved till Today !',
                    style: GoogleFonts.outfit(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 60,
            ),

            Text(
              'Crafted for you by',
              style: GoogleFonts.outfit(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Add some space between text and image
            Image.asset(
              'assets/logo2.png', // Replace with the path to your logo image
              width: 30, // Adjust the width as needed
              height: 30, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}
