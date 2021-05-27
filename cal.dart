import 'package:flutter/material.dart';

/*
 * Stateful widfget itself is immutable but its state is mutable
 * Stateless is an immutable widget
 * 
 * const - prevent rebuilding widget
 * */

void main() {
  runApp(
    MaterialApp(
      // stateful widget
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      theme: ThemeData(
          brightness: Brightness.dark, // for backgrund color
          primaryColor: Colors.indigo, //for app bar
          accentColor: Colors.indigoAccent //for overscoll edge effect and nobs
          ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: SIform(),
      ),
    ),
  );
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return form();
  }
}

class form extends State<SIform> {
  static const _currencies = ['Rupees', 'Dollars', 'Pounds'];
  String currencies = _currencies[0];

  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();

  String displayresult = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: principal,
                decoration: InputDecoration(
                  labelText: 'Principle',
                  hintText: 'Enter Principle e.g. 12000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: roi,
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In Percentage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            
           
            
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      controller: term,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'In year',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 20.0),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String dropdownitem) {
                        return DropdownMenuItem<String>(
                          value: dropdownitem,
                          child: Text(dropdownitem),
                        );
                      }).toList(),
                      value: currencies,
                      onChanged: (String valueselected) {
                        setState(() {
                          currencies = valueselected;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    width: 125.0,
                    height: 50.0,
                    child: MaterialButton(
                        child: Text(
                          "Calculate",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        elevation: 20.0,
                        onPressed: () {
                          setState(() {
                            this.displayresult = _calculatetotareturns();
                          });
                        }),
                  )),
                  Container(width: 10.0),
                  Expanded(
                      child: Container(
                    width: 125.0,
                    height: 50.0,
                    child: MaterialButton(
                        child: Text(
                          "Reset",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        elevation: 6.0,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },),
                  ),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                displayresult,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Center(
      child: Container(margin: EdgeInsets.all(20.0), child: image),
    );
  }

  String _calculatetotareturns() {
    double principaldata = double.parse(principal.text);
    double roidata = double.parse(roi.text);
    double termdata = double.parse(term.text);

    double totalAmount =
        principaldata + (principaldata * roidata * termdata) / 100;

    String result =
        "After $termdata  years, your investment will be worth $totalAmount $currencies";
    return result;
  }

  void _reset() {
    currencies = _currencies[0];
    principal.text = "";
    roi.text = "";
    term.text = "";
    displayresult = "";
  }
}
