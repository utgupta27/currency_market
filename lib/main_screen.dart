import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var infos;
  bool isLoading = false;
  Future<List> getData() async {
    String myUrl =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
    var req = await http.get(Uri.parse(myUrl),
        headers: {"X-CMC_PRO_API_KEY": "469a77a9-9be8-429a-9393-82c7645d67fd"});
    infos = json.decode(req.body);
    // print(infos['data'].toString());
    return infos['data'];
  }

  int getCount(data) {
    int count = 0;
    for (var i in data) {
      print(i);
      count += 1;
    }
    return count;
  }

  getName(data, index) {
    return data[index]['name'];
  }

  // getAge(data, index) {
  //   return data[index]['min_age_limit'];
  // }

  // getAvailableDose1(data, index) {
  //   return data[index]['available_capacity_dose1'];
  // }

  // getAvailableDose2(data, index) {
  //   return data[index]['available_capacity_dose2'];
  // }

  // getFeeType(data, index) {
  //   return data[index]['fee_type'];
  // }

  // getFee(data, index) {
  //   return data[index]['fee'];
  // }

  // getVaccine(data, index) {
  //   return data[index]['vaccine'];
  // }

  // getCenterId(data, index) {
  //   return data[index]['center_id'];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              // print('project snapshot data is: ${projectSnap.data}');
              return Center(child: CircularProgressIndicator());
            }
            // print('project snapshot data is: ${projectSnap.data}');
            // var ind = projectSnap.data.length;
            return ListView.builder(
              itemCount: getCount(projectSnap.data),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // height: 50,
                  width: double.maxFinite,
                  child: Card(
                    child: ExpansionTile(
                      // backgroundColor: Colors.blue[100],
                      collapsedBackgroundColor: Colors.grey[100],
                      title: Text(
                        getName(projectSnap.data, index),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: ,
                      children: <Widget>[],
                    ),
                  ),
                );
              },
            );
          },
          future: getData(),
        ),
      ),
    );
  }
}
