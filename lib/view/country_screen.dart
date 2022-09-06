import 'package:covid_tracker/services/stats_services.dart';
import 'package:covid_tracker/view/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var futureData = StatsServices().fetchAllCountriesData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                  ],
                  decoration: const InputDecoration(
                      hintText: 'search for country',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: futureData,
                      builder: (context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (!snapshot.hasData) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListView.builder(
                                itemCount: 15,
                                itemBuilder: (ctx, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          height: 20,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        title: Container(
                                          height: 20,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 20,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (ctx, index) {
                                String name =
                                snapshot.data![index]['country'].toString();
                                if (_controller.text.isEmpty) {
                                  return ListTile(
                                    onTap: () {
                                      _controller.clear();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CountryDetailScreen(
                                                      name: snapshot
                                                          .data![index]['country'],
                                                      flag: snapshot
                                                          .data![index]['countryInfo']['flag'],
                                                      totalCases: snapshot
                                                          .data![index]['cases'],
                                                      totalDeaths: snapshot
                                                          .data![index]['deaths'],
                                                      totalRecovered: snapshot
                                                          .data![index]['recovered'],
                                                      active: snapshot
                                                          .data![index]['active'],
                                                      critical: snapshot
                                                          .data![index]['critical'],
                                                      todayRecovered: snapshot
                                                          .data![index]['todayRecovered'],
                                                      todayCases: snapshot
                                                          .data![index]['todayCases'],
                                                      test: snapshot
                                                          .data![index]['tests'])));
                                    },
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]
                                            ['countryInfo']['flag'])),
                                    title: Text(snapshot.data![index]['country']
                                        .toString()),
                                    subtitle: Row(
                                      children: [
                                        Text("total cases: "),
                                        Text(snapshot.data![index]['cases']
                                            .toString())
                                      ],
                                    ),
                                  );
                                } else if (name
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase())) {
                                  return ListTile(
                                    onTap: () {
                                      _controller.clear();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CountryDetailScreen(
                                                    name: snapshot
                                                        .data![index]['country'],
                                                    flag: snapshot
                                                        .data![index]['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered: snapshot
                                                        .data![index]['recovered'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    critical: snapshot
                                                        .data![index]['critical'],
                                                    todayRecovered: snapshot
                                                        .data![index]['todayRecovered'],
                                                    todayCases: snapshot
                                                        .data![index]['todayCases'],
                                                    test: snapshot
                                                        .data![index]['tests'])),);
                                    },
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]
                                            ['countryInfo']['flag'])),
                                    title: Text(snapshot.data![index]['country']
                                        .toString()),
                                    subtitle: Row(
                                      children: [
                                        Text("total cases: "),
                                        Text(snapshot.data![index]['cases']
                                            .toString())
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        }
                      }))
            ],
          )),
    );
  }
}
