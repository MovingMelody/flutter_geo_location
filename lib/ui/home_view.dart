import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'homeview_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("get user location"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("lat : " + model.lat.toString())),
                Center(child: Text("long : " + model.long.toString())),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      model.position();
                    },
                    child: Text("GET COORDINATES")),
                SizedBox(
                  height: 30.0,
                ),
                model.isBusy
                    ? CircularProgressIndicator()
                    : Center(child: Text(model.data!.toUpperCase())),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
