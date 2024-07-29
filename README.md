# nice 본인인증 샘플

## flow
1. APP 에서 Server에 토큰 요청 (main.dart)
2. Server에서 APP에 토큰 발급 (main.dart)
3. APP에서 토큰 들고 웹뷰 호출 (niceExamplePage.dart)
    1. `onWebViewCreated` 에서 웹에 데이터를 넘기기 위한 handler 설정 필수
    2. (테스트 코드에는 local asset을 가져오도록 되어있음)
    3. (prod 에서는 별도의 html을 서빙해서 처리해야 함)
4. Web에서 본인인증 프로세스 시작 (index.html)
5. Web에서 본인인증 완료 후 Callback URL로 데이터 전송 (success.html)
   1. 현재는 `https://api.fitbuddy.co.kr/api/v2/auth/nice/callback` 로 콜백되는중
   2. (prod 에서는 별도의 콜백 URL을 설정해야 함)
6. Callback Web에서 데이터를 받아 APP으로 전송 (success.html)
7. APP에서 받은 데이터를 Server로 전송 후 알아서 처리 (niceExamplePage.dart)

