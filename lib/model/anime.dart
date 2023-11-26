class Anime {

  int? malId;
  Images? images;
  String? title;
  int? episodes;
  int? members;
  int? year;

  Anime(
      {this.malId,
        this.images,
        this.title,
        this.episodes,
        this.members,
        this.year,
       }
  );

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    title = json['title'];
    episodes = json['episodes'];
    members = json['members'];
    year = json['year'];
    }

  //retorna un mapa con los datos que se tenga en esta clase
  //para el repository
  Map<String,dynamic> toMap(){
    return {
      'malId':malId,
      'images':images!.toMap(),  //"!.toMap()"->para que llame al to map de la clase images
      'title':title,
      'episodes':episodes,
      'members':members,
      'year':year,
    };
  }

}

class Images {
  Jpg? jpg;

  Images({this.jpg});

  Images.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? new Jpg.fromJson(json['jpg']) : null;
  }

  //retorna un mapa con los datos que se tenga en esta clase
  //para el repository
  Map<String,dynamic> toMap(){
    return {
      'jpg':jpg!.toMap(),   //"!.toMap()"->para que llame al to map de la clase Jpg
    };
  }
}

class Jpg {
  String? imageUrl;

  Jpg({this.imageUrl});

  Jpg.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  //retorna un mapa con los datos que se tenga en esta clase
  //para el repository
  Map<String,dynamic> toMap(){
    return {
      'imageUrl':imageUrl,
    };
  }
}
