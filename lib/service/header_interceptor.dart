import 'dart:async';
import 'package:chopper/chopper.dart';

// 1
class HeaderInterceptor implements RequestInterceptor {
  // 2
  static const String AUTH_HEADER = "Authorization";
  // 3
  static const String BEARER = "Bearer ";
  // 4
  static const String V4_AUTH_HEADER =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmI2MjljYTViYjk1MGExZDAwYTNkMTQ5NDdmOGM1OSIsInN1YiI6IjYwMDFmZWNiMmY3OTE1MDAzZTk5ODAxMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.z9ymxWxMLXKPTlHw0k5L1g2FbzXI72nBiTy6enMNiPY";

  @override
  FutureOr<Request> onRequest(Request request) async {
    // 5
    Request newRequest =
        request.copyWith(headers: {AUTH_HEADER: BEARER + V4_AUTH_HEADER});
    return newRequest;
  }
}
