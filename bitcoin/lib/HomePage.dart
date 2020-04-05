import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String _priceBuy = "0";
  String _priceSell = "0";
  
  void _getPrice() async {
    String  url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> responseConverted = json.decode(response.body);

    setState(() {
      _priceBuy = responseConverted["BRL"]["buy"].toString();
    });
    setState(() {
      _priceSell = responseConverted["BRL"]["sell"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 15,),
                child: Text(
                  'R\$ ' + _priceBuy,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: FlatButton(
                  onPressed: _getPrice,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(9.0)), 
                  color: Colors.orange,
                  child: Text(
                    'Atualizar',
                    style: TextStyle(color:Colors.white, fontSize: 18),
                  ),
                  padding: EdgeInsets.only(top:10, bottom: 10, right: 20, left: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}