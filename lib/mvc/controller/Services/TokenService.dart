class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
  }
}
