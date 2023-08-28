import 'dart:convert';
import 'dart:io';
import 'package:bitcointracker/Model%20Class/bitcoin_Model.dart';
import 'package:http/http.dart' as http;


class BitCoinService{

  dynamic handlebitcoinResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        print('unauthorized err ${jsonDecode(response.body)}');
        throw HttpException('Unauthorized');
      default:
        print('got err response from handler ${jsonDecode(response.body)}');
        throw HttpException('Failed to get bit coin details');
    }
  }

  Future GetDetails() async {
    try {
      var response = await http.get(
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final responseData = handlebitcoinResponse(response);
      BitCoin coinsdetails = BitCoin.fromJson(responseData);
      return coinsdetails;
    }
    catch (err) {
      throw err;
    }
  }

}
