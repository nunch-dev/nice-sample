import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nice_sample/niceExamplePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _makePostRequest() async {
    final url = Uri.parse('https://api.fitbuddy.co.kr/api/v2/auth/nice');
    final headers = {"Content-Type": "application/json"};

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final _tokenVersionId = responseData['tokenVersionId'];
        final _encData = responseData['encData'];
        final _integrityValue = responseData['integrityValue'];

        print(_tokenVersionId);
        print(_encData);
        print(_integrityValue);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NiceExamplePage(
                  tokenVersionId: _tokenVersionId,
                  encData: _encData,
                  integrityValue: _integrityValue,
                ),
          ),
        );
      }
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('본인인증 샘플')
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: _makePostRequest, child: Text('본인인증하기')
                  )
                ]
            )
        )
    );
  }
}
