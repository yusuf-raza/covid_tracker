import 'dart:convert';

import 'package:covid_tracker/model/AllStatsModel.dart';
import 'package:covid_tracker/services/utilites/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<AllStatsModel> fetchAllStatsData() async {
    var response = await http.get(Uri.parse(ApiUrls.allStats));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      print('global api hit!');
      return AllStatsModel.fromJson(data);
    } else {
      print('global api failed!');
      return AllStatsModel.fromJson(data);
    }


  }

  Future<List<dynamic>> fetchAllCountriesData() async {
    var response = await http.get(Uri.parse(ApiUrls.countryStats));
    var data;

    
    if (response.statusCode == 200) {
      data  = jsonDecode(response.body);
      print('countries api hit!');

      return data;
    } else {
      print('country api failed!');
      return data;
    }


  }
}
