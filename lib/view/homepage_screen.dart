import 'dart:async';

import 'package:covid_tracker/model/AllStatsModel.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:covid_tracker/view/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3));

  //List<Color> colorList = <Color>[Colors.blue, Colors.red, Colors.green];

  @override
  void initState() {
    // TODO: implement initState
    /* Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Homepage()));
    });
    super.initState();*/
  }

  @override
  void dispose() {
    //_animationController.dispose();
    super.dispose();
  }

  StatsServices allStats = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Stats'), centerTitle: true, elevation: 0,automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: allStats.fetchAllStatsData(),
                  builder: (context,AsyncSnapshot<AllStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            controller: _animationController,
                            color: Colors.white,
                          ));
                    } else {
                      print('snapshot has no data');

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        PieChart(chartType: ChartType.ring,
                            //colorList: colorList,
                            chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                            dataMap: {
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              "Total cases": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),

                            }),
                          const SizedBox(height: 20,),
                          Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Text('Total cases'),
                                  trailing: Text(snapshot.data!.cases.toString()),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Text('Active cases'),
                                  trailing: Text(snapshot.data!.active.toString()),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Text('Recovered'),
                                  trailing: Text(snapshot.data!.recovered.toString()),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Text('Deaths'),
                                  trailing: Text(snapshot.data!.deaths.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => CountryScreen()));
                                  }, child: const Text("Country Data", style: const TextStyle(fontSize: 20),)),
                                )
                              ],
                            )
                          )

                      ],);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
