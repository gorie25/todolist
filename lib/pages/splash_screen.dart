import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () {
      GoRouter.of(context).go('/home'); // Sử dụng GoRouter để điều hướng   
         });

      // TODO: implement initState
    super.initState();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Center(

    child: Container(
       width: 200,
       height: 200,
      
      child: Image.asset('assets/logo.png')),
    );
  }
}