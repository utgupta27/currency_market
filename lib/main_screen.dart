import 'package:currency_market/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:currency_market/store.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var infos;
  List<int> favo = [];
  bool isLoading = false;
  Future<List> getData() async {
    String myUrl =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
    var req = await http.get(Uri.parse(myUrl),
        headers: {"X-CMC_PRO_API_KEY": "469a77a9-9be8-429a-9393-82c7645d67fd"});
    infos = json.decode(req.body);
    return infos['data'];
  }

  int getCount(data) {
    int count = 0;
    for (var i in data) {
      count += 1;
    }
    return count;
  }

  getName(data, index) {
    return data[index]['name'];
  }

  int getId(data, index) {
    return data[index]["id"];
  }

  getSymbol(data, index) {
    return data[index]["symbol"];
  }

  getPrice(data, index) {
    var price = data[index]['quote']['USD']['price'];
    return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
  }

  getPercentChange24h(data, index) {
    var perc = data[index]['quote']['USD']['percent_change_24h'];
    return perc.toStringAsFixed(perc.truncateToDouble() == perc ? 0 : 2);
  }

  getMarketCap(data, index) {
    var marCap = data[index]['quote']['USD']['market_cap'];
    marCap = marCap / 1000000000;
    return marCap.toStringAsFixed(marCap.truncateToDouble() == marCap ? 0 : 2);
  }

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
            if (projectSnap.data == Null) {
              Center(child: Text("${projectSnap.hasError}"));
            }
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
                      title: ListTile(
                        leading: Container(
                          child: Column(
                            children: [
                              const Text(
                                "Rank",
                              ),
                              Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        title: Row(
                          children: [
                            SizedBox(
                              height: 35,
                              width: 35,
                              child: Image.network(
                                  "https://s2.coinmarketcap.com/static/img/coins/64x64/" +
                                      getId(projectSnap.data, index)
                                          .toString() +
                                      ".png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 130,
                              child: Text(
                                getName(projectSnap.data, index),
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // subtitle: ,
                      children: <Widget>[
                        Text(
                          getSymbol(projectSnap.data, index),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(
                                    getPrice(projectSnap.data, index)
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Market Capital",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(
                                    getMarketCap(projectSnap.data, index)
                                            .toString() +
                                        " Bn",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Past 24Hrs",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(
                                    getPercentChange24h(projectSnap.data, index)
                                            .toString() +
                                        " %",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // add(getSymbol(projectSnap.data, index));
                                  if (!favo.contains(index + 1)) {
                                    favo.add(index + 1);
                                    const snackBar = SnackBar(
                                        content: Text('Added to Favourites'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    const snackBar = SnackBar(
                                        content: Text('Already Added'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: const Text("Add to Favourites")),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       // remove(getSymbol(projectSnap.data, index));
                            //       favo.remove(getId(projectSnap.data, index));
                            //       const snackBar = SnackBar(
                            //           content: Text('Removed from Favourites'));
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(snackBar);
                            //     },
                            //     child: const Text("Remove Favourites")),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: getData(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FavScreen(
                info: infos,
                favos: favo,
              ),
            ),
          );
        },
        child: const Icon(Icons.favorite),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
