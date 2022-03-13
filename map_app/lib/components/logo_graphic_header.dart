import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/togg-logo.png';

    return Hero(
        tag: 'App Logo',
        child: SizedBox(
          height: 70,
          child: Container(
            child: Image.asset(
              _imageLogo,
              fit: BoxFit.fitHeight,
            ),
          ),
        ));
  }
}
