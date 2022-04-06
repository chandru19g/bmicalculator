import 'package:bmicalculator/routes/routes.dart';
import 'package:bmicalculator/services/ad_service.dart';
import 'package:bmicalculator/services/value_service.dart';
import 'package:bmicalculator/ui/themes.dart';
import 'package:bmicalculator/ui/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdService adService = AdService();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _checkVersion();
  // }

  Future<void> _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.chandru.bmicalculator",
    );

    print(newVersion);

    final status = await newVersion.getVersionStatus();

    print("${status?.localVersion} ${status?.storeVersion}");

    newVersion.showUpdateDialog(
      context: context,
      versionStatus: status!,
      dialogTitle: "UPDATE",
      dismissButtonText: "close",
      dialogText:
          "A new version of the App is available in play store.\nDownload Now",
      dismissAction: () {
        SystemNavigator.pop();
      },
      updateButtonText: "Update",
    );
  }

  @override
  Widget build(BuildContext context) {
    final interstitialAd = context.read<AdService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: Themes().valueStyle.copyWith(color: Colors.white),
        ),
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Consumer<ValueService>(
        builder: (context, value, child) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 14, bottom: 18.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleBox("Gender"),
                    _genderBox(context, value),
                    const SizedBox(
                      height: 15.0,
                    ),
                    _titleBox("Height"),
                    const SizedBox(
                      height: 15.0,
                    ),
                    _valueBox(
                      value: value.height,
                      minusFunction: () =>
                          context.read<ValueService>().decrementHeight(),
                      addFunction: () =>
                          context.read<ValueService>().incrementHeight(),
                      unit: "cm",
                      widget: true,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    _titleBox("Weight"),
                    const SizedBox(
                      height: 15.0,
                    ),
                    _valueBox(
                      value: value.weight,
                      minusFunction: () =>
                          context.read<ValueService>().decrementWeight(),
                      addFunction: () =>
                          context.read<ValueService>().incrementWeight(),
                      unit: "kg",
                      widget: true,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    _titleBox("Age"),
                    const SizedBox(
                      height: 15.0,
                    ),
                    _valueBox(
                      value: value.age,
                      minusFunction: () =>
                          context.read<ValueService>().decrementAge(),
                      addFunction: () =>
                          context.read<ValueService>().incrementAge(),
                      widget: false,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    MyButton(
                      buttonText: "Calculate",
                      onTapped: () {
                        interstitialAd.interstitial.show();
                        context.read<ValueService>().calculateBmi();
                        context.read<ValueService>().getInterpretation();
                        Navigator.of(context)
                            .pushNamed(RouteManager.resultScreen);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _valueBox({
    required int value,
    required Function() minusFunction,
    required Function() addFunction,
    String? unit,
    required bool widget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50.0,
                    child: ElevatedButton(
                      onPressed: minusFunction,
                      child: const Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      style: Themes().buttonStyle,
                    ),
                  ),
                ),
                Text(
                  value.toString(),
                  style: Themes().valueStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50.0,
                    child: ElevatedButton(
                      onPressed: addFunction,
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      style: Themes().buttonStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widget
            ? Container(
                margin: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width / 3.2,
                color: Colors.white,
                height: 50.0,
                child: Center(
                  child: Text(
                    unit!,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _titleBox(String title) {
    return Text(
      title,
      style: Themes().headerStyle,
    );
  }

  _genderBox(BuildContext context, ValueService value) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ValueService>().updateBoxColor(1);
            },
            child: _containerBox(
              FontAwesomeIcons.person,
              value.maleBoxColor,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ValueService>().updateBoxColor(0);
            },
            child: _containerBox(
              FontAwesomeIcons.personDress,
              value.femaleBoxColor,
            ),
          ),
        ),
      ],
    );
  }

  _containerBox(IconData icon, Color color) {
    return Container(
      height: 200.0,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Themes.darkHeaderClr,
        border: Border.all(color: color, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: color == Colors.green ? color : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Icon(
            icon,
            size: 100.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
