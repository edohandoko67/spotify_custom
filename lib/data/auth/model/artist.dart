class Artist {
  Followers? followers;
  List<String>? genres;
  String? id;
  List<Images>? images;
  String? name;
  int? popularity;
  String? type;

  Artist({
   this.followers,
   this.genres,
   this.id,
   this.images,
    this.name,
    this.popularity,
    this.type
});
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      followers: json['followers'] != null
        ? Followers.fromJson(json['followers'])
        : null,
      images: (json['images'] as List<dynamic>)
        .map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),
      name: json['name'] ?? '',
      popularity: json['popularity'] ?? '',
      type: json['type'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'genres': genres,
      'followers': followers?.toJson(), // Memetakan Followers kembali ke JSON
      'images': images?.map((e) => e.toJson()).toList(),
      'name': name,
      'popularity': popularity,
      'type': type,
    };
  }
}

class Genres {
// List yang menyimpan genre
  List<String>? genres;

  Genres({
    this.genres
});

  factory Genres.fromJson(Map<String, dynamic> json) {
    // Menyaring dan mengonversi data JSON menjadi List<String>
    return Genres(
      genres: List<String>.from(json['genres'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genres': genres
    };
  }
}

class Followers {
  int? total;

  Followers({
    this.total
});

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      total: json['total'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total
    };
  }
}

class Images {
  String? url;

  Images({
    this.url});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      url: json['url'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url
    };
  }
}