// ignore_for_file: prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_unnecessary_containers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/order_tracking.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OrderTracker(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 100),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6CB65A), // Green
              Color(0xFF6CB65A), // Greens

              Color(0xFF6552FE), // Purple

              Color(0xFF6552FE), // Purple
            ],
            stops: [0, 1 / 3, 2 / 3, 1],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Success Payment',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                  height: 120), // Add some space between text and image
              Image.asset(
                '/Users/agro/development/trail/pox/lib/assets/images/clocky.gif', // Replace with the path to your logo image
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
              const SizedBox(
                height: 40,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Saved',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                  children: [
                    TextSpan(
                      text: ' 30-35 minutes,\n',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    ),
                    TextSpan(
                      text: ' sunstroke-free.',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Made with Love',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      'assets/logo.png', // Replace with the path to your logo image
                      width: 120, // Adjust the width as needed
                      height: 120, // Adjust the height as needed
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
