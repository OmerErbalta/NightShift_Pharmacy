import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobetci_eczane/all_providers.dart';
import 'package:nobetci_eczane/widgets.dart';

import 'homePage.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  void initState() {
    super.initState();
    ref.read(getAdress);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset("assets/images/logo.png"),
      ),
      duration: 1000,
      nextScreen: const HomePage(),
    );
  }
}
