import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NiceExamplePage extends StatefulWidget {
  final String tokenVersionId;
  final String encData;
  final String integrityValue;

  const NiceExamplePage({
    super.key,
    required this.tokenVersionId,
    required this.encData,
    required this.integrityValue,
  });

  @override
  State<NiceExamplePage> createState() => _NiceExampleState();
}

class _NiceExampleState extends State<NiceExamplePage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        child: InAppWebView(
          key: webViewKey,
          // 테스트용 로컬 html 파일
          initialFile: "assets/index.html",
          // 별도 도메인 경로를 사용할 경우 아래 주석을 해제하고 initialUrlRequest를 사용
          // initialUrlRequest: URLRequest(
          //   url: Uri.parse("https://본인인증 경로")
          // ),
          initialSettings: InAppWebViewSettings(),
          onWebViewCreated: (controller) {
            webViewController = controller;

            controller.addJavaScriptHandler(
                // index.html 내 callHandler의 핸들러 이름과 동일하게 맞춰야 함
                handlerName: 'onReady',
                callback: (args) {
                  // return 값은 index.html 내 callHandler의 콜백함수로 전달됨
                  return {
                    'tokenVersionId': widget.tokenVersionId,
                    'encData': widget.encData,
                    'integrityValue': widget.integrityValue,
                  };
                });

            controller.addJavaScriptHandler(
                handlerName: 'success',
                callback: (args) {
                  // TODO 성공시 데이터 처리
                  print(args);
                });
          },
        ),
      ),
    ]));
  }
}
