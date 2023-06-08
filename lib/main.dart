import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'data.dart';
import 'package:intl/intl.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  runApp(const Myapp());}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff000000),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Univest')),
        body: indiplans(),
      ),
    );
  }
}


class indiplans extends StatefulWidget {
  const indiplans({super.key});
  @override
  State<indiplans> createState() => _indiplansState();
}
class _indiplansState extends State<indiplans> {

  var url;
  var filename;

  void initState() {
    super.initState();
    url = 'https://univest.s3.ap-south-1.amazonaws.com/razorpay-invoices/invoice.pdf';
    filename = 'download.pdf';
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const Text('Indi PLANS'),
          onPressed: () async {
            var data = await Data.getdata();
            setState(() {
              bottomsheet(data);
            });
          }
      ),
    );
  }
  void bottomsheet(dynamic data){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('PRO membership',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff202020),
                              fontSize: 24
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Active plan :${data['activePlanDetails']['planName']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff202020),
                              fontSize: 14
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Purchased on',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff606060),
                                        fontSize: 12
                                    )),
                                Text(DateFormat('dd MMM "yy').format(DateTime.fromMillisecondsSinceEpoch(data['activePlanDetails']['purchasedOn'])),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff202020),
                                        fontSize: 14
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Purchase Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff606060),
                                      fontSize: 12
                                  )),
                              Text(data['activePlanDetails']['purchasePrice'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff202020),
                                      fontSize: 14
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expires on',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff606060),
                                        fontSize: 12
                                    )),
                                Text(DateFormat('dd MMM "yy').format(DateTime.fromMillisecondsSinceEpoch(data['activePlanDetails']['renewalOn'])),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff202020),
                                        fontSize: 14
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Text('Renewal Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff606060),
                                      fontSize: 12
                                  )),
                              Text(data['activePlanDetails']['renewalPrice'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff202020),
                                      fontSize: 14
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          child: const Text(
                              'Download invoice',
                              style:
                              TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize:12,
                                fontWeight:FontWeight.w500,
                                color: Color(0xff00439D),
                              )
                          ),
                          onPressed:()
                          {
                            download(url, filename);
                          }
                      ),
                    ),
                    SizedBox(
                      height: 50, //height of button
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.black)),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                          ),
                          child: const Text(
                            'Alright!',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff202020),
                                fontSize: 16
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ],
                ),
              );},);
        });
  }

  Future download(String url, String filename) async {
    Future<String?> stringFuture = getDownloadPath();
    String? getPath = await stringFuture;
    var savePath=getPath.toString()+filename;
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 120),
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS)
      {
        directory = await getApplicationDocumentsDirectory();
      }
      else
      {
        directory = Directory('/storage/emulated/0/Download/');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

}

