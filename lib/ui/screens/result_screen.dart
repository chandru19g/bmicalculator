import 'package:bmicalculator/services/ad_service.dart';
import 'package:bmicalculator/services/banner_service.dart';
import 'package:bmicalculator/services/value_service.dart';
import 'package:bmicalculator/ui/themes.dart';
import 'package:bmicalculator/ui/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late BannerAd banner;
  bool _isAdReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = context.read<BannerService>();

    setState(() {
      banner = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: adState.bannerAdUnitId,
        listener: adState.adBannerListener,
        request: const AdRequest(),
      )..load();

      _isAdReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AdService>().interstitial.show();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
      ),
      body: Consumer<ValueService>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 14,
              bottom: 18.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          "Result",
                          style:
                              Themes().valueStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2.4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: value.bmi >= 18.5 && value.bmi < 25
                              ? Colors.green
                              : value.bmi >= 25 && value.bmi < 30
                                  ? Colors.orange
                                  : value.bmi >= 30
                                      ? Colors.red
                                      : Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Your Current BMI",
                                style: Themes()
                                    .headerStyle
                                    .copyWith(color: Colors.grey[200]),
                              ),
                              Text(
                                value.bmi.toStringAsFixed(1),
                                style: Themes().valueStyle.copyWith(
                                    color: Colors.white, fontSize: 40.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Text(
                                  value.bmiResult,
                                  style: Themes()
                                      .headerStyle
                                      .copyWith(color: Colors.grey[200]),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _isAdReady
                          ? SizedBox(
                              height: 100.0,
                              child: AdWidget(
                                ad: banner,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                MyButton(
                  buttonText: "Recalculate BMI",
                  onTapped: () {
                    context.read<AdService>().interstitial.show();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
