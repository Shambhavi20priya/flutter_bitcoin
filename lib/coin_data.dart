import 'dart:convert';

import 'package:http/http.dart' as http;



const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const coinAPIURL='https://rest.coinapi.io/v1/exchangerate';
const apikey='417ACF1A-9969-46FB-8E1C-2A4D58294188';





class CoinData {
  Future getCoinData(String selectedcurrency)async{
    String requestedURL='$coinAPIURL/BTC/$selectedcurrency?apikey=$apikey';
    Uri uri=Uri.parse(requestedURL);  //http.get expects uri format so converting string to uri
    http.Response response=await http.get(uri);
    if(response.statusCode==200){
      var decode=jsonDecode(response.body);
      var lastprice=decode['rate'];
      return lastprice;
    }
    else{
      print('Error in receiving the data from API');
    }

  }
}
