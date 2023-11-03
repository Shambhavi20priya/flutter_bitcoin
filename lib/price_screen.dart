import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io'show Platform;
import '';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedstate = 'USD';
  String selectedcurrency='AUD';          //CHANGE SILVER

//android

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      var newItem = DropdownMenuItem<String>
      (
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedcurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedcurrency = value ?? 'AUD';
          getData();
        });
      },
    );
  }


//ios
  CupertinoPicker iosPicker(){

    List<Text> pickeritems=[];
    for(int i=0;i<currenciesList.length;i++){
      String currency=currenciesList[i];
      pickeritems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,onSelectedItemChanged:(selectedIndex) {
      print(selectedIndex);
      setState(() {                   //changes silver challenge
         selectedcurrency =currenciesList[selectedIndex];
         getData();
      });
    },children:
    pickeritems,
    );


  }
String bitcoinValue='?';
void getData()async
{
  try{
    double data=await CoinData().getCoinData(selectedcurrency);
    setState(() {
      bitcoinValue=data.toStringAsFixed(0);
    });
  }catch(e){
    print(e);
  }

}
@override
void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Text(
                  '1 BTC = $bitcoinValue $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isAndroid?androidDropDownButton():iosPicker(),
          ),
        ],
      ),
    );
  }
}

//