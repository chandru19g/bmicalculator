import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerService extends ChangeNotifier {
  String get bannerAdUnitId => "ca-app-pub-4557012671852782/1856040362";

  AdListener get adBannerListener => _adBannerListener;

  final AdListener _adBannerListener = AdListener(
    onAdLoaded: (ad) => print("Ad Loaded "),
    onAdClosed: (ad) => print("Ad Closed"),
    onAdFailedToLoad: (ad, error) => print("Ad Failed To Load"),
    onAdOpened: (ad) => print("Ad Opened"),
    onAppEvent: (ad, name, data) => print("App Event"),
    onApplicationExit: (ad) => print("Application Exit"),
  );
}
