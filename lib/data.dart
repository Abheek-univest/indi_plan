import 'dart:convert';
import 'package:http/http.dart' as http;

var value = {"activePlanDetails":{"planName":"14-day free trial","planId":"plan_000","purchasedOn":1685473026613,"renewalOn":1688237826611,"purchasePrice":null,"renewalPrice":0}};

class Data
{
  static dynamic getdata() async{
    var url=(Uri.parse("https://jsonblob.com/api/1115609979729231872"));
      final response= await http.get(url);
      if(200==response.statusCode)
      {
        dynamic data=jsonDecode(response.body);
        return data;
      }
  }
}
