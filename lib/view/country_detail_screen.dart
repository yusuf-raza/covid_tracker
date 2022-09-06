import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryDetailScreen extends StatelessWidget {
  const CountryDetailScreen(
      {Key? key,
      required this.name,
      required this.flag,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.todayCases})
      : super(key: key);

  final String name, flag;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      todayCases,
      test;

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image(
            image: NetworkImage(flag),
            height: 150,
            width: 150,
          )),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .80000000000,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: PieChart(
                            chartType: ChartType.ring,
                            //colorList: colorList,
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            dataMap: {
                              "Deaths": double.parse(totalDeaths.toString()),
                              "Total cases":
                                  double.parse(totalCases.toString()),
                              "Recovered":
                                  double.parse(totalRecovered.toString()),
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total cases",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(totalCases.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total deaths", style: TextStyle(fontSize: 18)),
                          Text(totalDeaths.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total tests conducted",
                              style: TextStyle(fontSize: 18)),
                          Text(test.toString(), style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total recovered",
                              style: TextStyle(fontSize: 18)),
                          Text(totalRecovered.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total active cases",
                              style: TextStyle(fontSize: 18)),
                          Text(active.toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
