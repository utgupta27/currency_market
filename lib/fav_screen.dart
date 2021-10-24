import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  final info;
  final favos;
  const FavScreen({Key? key, this.info, this.favos}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  getPrice(data) {
    var price = data;
    return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
  }

  getPercentChange24h(data) {
    var perc = data;
    return perc.toStringAsFixed(perc.truncateToDouble() == perc ? 0 : 2);
  }

  getMarketCap(data) {
    var marCap = data;
    marCap = marCap / 1000000000;
    return marCap.toStringAsFixed(marCap.truncateToDouble() == marCap ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: Colors.blue[900],
      ),
      body: widget.favos == []
          ? Text("Nothing is here")
          : Container(
              child: ListView.builder(
                  itemCount: widget.favos.length,
                  itemBuilder: (BuildContext context, int index) {
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
                                    (widget.favos[index]).toString(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
                                          widget.info['data']
                                                  [widget.favos[index] - 1]
                                                  ['id']
                                              .toString() +
                                          ".png"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    widget.info['data'][widget.favos[index] - 1]
                                            ['name']
                                        .toString(),
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
                              widget.info['data'][widget.favos[index] - 1]
                                  ['symbol'],
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
                                        getPrice(widget.info['data']
                                                    [widget.favos[index] - 1]
                                                ['quote']['USD']['price'])
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
                                        getMarketCap(widget.info['data'][
                                                        widget.favos[index] -
                                                            1]['quote']['USD']
                                                    ['market_cap'])
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
                                        getPercentChange24h(widget.info['data'][
                                                        widget.favos[index] -
                                                            1]['quote']['USD']
                                                    ['percent_change_24h'])
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
                                // ElevatedButton(
                                //     onPressed: () {
                                //       add(getSymbol(projectSnap.data, index));
                                //       favo.add(getId(projectSnap.data, index));
                                //       const snackBar = SnackBar(
                                //           content: Text('Added to Favourites'));
                                //       ScaffoldMessenger.of(context)
                                //           .showSnackBar(snackBar);
                                //     },
                                //     child: const Text("Added to Favourites")),
                                ElevatedButton(
                                    onPressed: () {
                                      // remove(getSymbol(projectSnap.data, index));
                                      setState(() {
                                        widget.favos
                                            .remove(widget.favos[index]);
                                      });
                                      const snackBar = SnackBar(
                                          content:
                                              Text('Removed from Favourites'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: const Text("Remove Favourites")),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
