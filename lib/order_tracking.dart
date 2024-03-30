// ignore_for_file: unused_local_variable, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/order_trackking_details.dart';
import 'package:lunchx_customer/student_dashboard.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({super.key});

  @override
  _OrderTrackerState createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        // Your refresh logic here
        // updateData();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width - 20.0; // Full width of the card
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6552FE),
        elevation: 10, // Removes the shadow
        shape: const RoundedRectangleBorder(
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Pop all routes until reaching the first route
            Navigator.popUntil(context, (route) => route.isFirst);

            // Push the student_dashboard screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // START COOKING CARDS
            OrderDetailsCard(cardWidth: MediaQuery.of(context).size.width),
            // END COOKING CARDS

            const SizedBox(
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

            const SizedBox(
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
            const SizedBox(height: 10), // Add some space between text and image
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
