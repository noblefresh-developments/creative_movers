import 'package:creative_movers/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatefulWidget {
  const OnboardingItem({Key? key, required this.text, required this.img, required this.header}) : super(key: key);
  final Widget text;
  final String header;
  final String img;

  @override
  _OnboardingItemState createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.OnboardingColor.withOpacity(0.2),
                AppColors.OnboardingColor.withOpacity(0.5),
                AppColors.OnboardingColor.withOpacity(1)

              ])),
        ),
        decoration:  BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(widget.img))
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Text(
             widget.header,
               textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            widget.text

            // Text(' dcsdc oidco d',style: TextStyle(fontSize: 20,color: Colors.white),
            // )
          ],
        ),
      )
    ]);
  }
}
