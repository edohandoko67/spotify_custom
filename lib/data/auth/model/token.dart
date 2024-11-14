class Token {
  String? access_token;
  String? tokenType;
  int? expired;

  Token({
    this.access_token,
    this.expired,
    this.tokenType
});
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token (
      access_token: json['access_token'] ?? '',
      expired: json['expires_in'] ?? 0,
      tokenType: json['token_type'] ?? ''
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
      'expires_in': expired,
      'token_type': tokenType
    };
  }
}