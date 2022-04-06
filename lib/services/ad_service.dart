import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends ChangeNotifier {
  String get interstitialAdUnitId => 'ca-app-pub-4557012671852782/2542436070';


  bool _loading = true;
  late InterstitialAd interstitial;

  AdService() {
    interstitial = result();
  }

  InterstitialAd result() {
    return InterstitialAd(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      listener: AdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdClosed: (ad) {
          ad.dispose();
          interstitial = result();
        },
        onAdLoaded: (ad) {
          _loading = false;
        },
      ),
    )..load().then((value) => _loading = true);
  }

  get loading => _loading;
}
