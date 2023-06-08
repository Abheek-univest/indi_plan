import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future download(String url, String filename) async {
    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  @override
  void initState() {
    super.initState();
    var url = 'https://www.africau.edu/images/default/sample.pdf';
    var filename = 'demo.pdf';
    download(url, filename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter PDF Example'),),
        body: const Text('Check your downloads folder!'));
  }
}