class Track {
  String? date_add;
  String? name;
  List<Artists>? artists;
  Album? album;
  UrlSong? external_urls;

  Track({
    this.date_add,
    this.album,
    this.name,
    this.artists,
    this.external_urls
});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      date_add: json['added_at'] ?? '',
      name: json['track']['name'] ?? '',
      artists: (json['track']['artists'] as List<dynamic>)
          .map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: json['track']['album'] != null
          ? Album.fromJson(json['track']['album'])
          : null,
      external_urls: json['track']['external_urls'] != null
        ? UrlSong.fromJson(json['track']['external_urls'])
          : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'added_at': date_add,
      'name': name,
      'album': album?.toJson(),
      'artists': artists?.map((e) => e.toJson()).toList(),
      'external_urls': external_urls?.toJson(),
    };
  }
}

class UrlSong {
  String? spotify;

  UrlSong({
    this.spotify
});

  factory UrlSong.fromJson(Map<String, dynamic> json) {
    return UrlSong(
      spotify: json['spotify'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spotify' : spotify
    };
  }
}

class Artists {
  String? name;

  Artists({
    this.name
});

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
      name: json['name'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
  }
}

class Album {
  String? name;

  Album({
    this.name,
});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
