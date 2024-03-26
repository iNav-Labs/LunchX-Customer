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
              const SizedBox(height: 40),
              Text(
                'Payment Successful',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 20), // Add space between text and image
              Image.asset(
                'assets/clocky.gif',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20), // Add space between image and text
              Text(
                'Your order has been successfully placed!',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // Add space between text and logo
              Image.asset(
                'assets/logo.png',
                width: 120,
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
