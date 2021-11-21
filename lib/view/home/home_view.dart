import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funwithml/utils/common_colors.dart';
import 'package:funwithml/utils/text_style.dart';
import 'package:funwithml/view/emotion_detection/emotion_detection_view.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel? mViewModel;

  @override
  void initState() {
    mViewModel = Provider.of<HomeViewModel>(context, listen: false);
    mViewModel!.attachContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Fun with ML"),
          backgroundColor: CommonColors.primaryColor,
          elevation: 1,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getCategory(
                  image:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGnIAlQRIjQDYB95RLwuUfKuY_2xo59i7xMtRUEJOL3I5Y3RMWSDBpBkk4XBsI_AK66AE&usqp=CAU",
                  catName: "Live Emotion detection")
            ],
          ),
        ));
  }

  Widget getCategory({String? image, String? catName}) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => EmotionDetectionView()));
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
          color: CommonColors.blue,
        )),
        child: Column(
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.network(
                  image!,
                  fit: BoxFit.fill,
                )),
            Text(
              catName!,
              style: CommonStyle.getGibsonStyle(
                color: CommonColors.black4a,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
