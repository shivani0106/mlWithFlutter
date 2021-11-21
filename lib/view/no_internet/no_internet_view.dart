import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funwithml/generated/i18n.dart';
import 'package:funwithml/utils/common_colors.dart';
import 'package:funwithml/utils/text_style.dart';

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("you are on no network");
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  S.of(context)!.noInternet,
                  style: CommonStyle.getGibsonStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: CommonColors.primaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
