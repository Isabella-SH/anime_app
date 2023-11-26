
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

  //recojemos la informacion de un pokemon de un json
  //claave: recibe primero el tipo de dato
  //dynamic: cualquier valor
  //                    clave,valor                 asi se llama en el json
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
      'image':images!.jpg!.imageUrl!,   //llega hasta la imagen que queremos
      'title':title,
      'episodes':episodes,
      'members':members,
      'year':year,
    };
  }

  //convierte un map a objeto Pokemon
  //sirve para que convierta lo que devuleve la tabla "pokemons" de nuestra base de datos creada
  //para el getAll()
  Anime.fromMap(Map<String, dynamic> map) {
    malId = map['malId'];
    title = map['title'];
    episodes = map['episodes'];
    members = map['members'];
    year = map['year'];

    if (map['image'] != null) {               //colocar entre los corchetes el nombre que este en la tabla
      images = Images.fromMap(map['image']);
    }
  }


}

class Images {
  Jpg? jpg;

  Images(this.jpg);

  Images.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? new Jpg.fromJson(json['jpg']) : null;
  }

  //retorna un mapa con los datos que se tenga en esta clase
  //para el repository
  Map<String,dynamic> toMap(){
    return {
      'jpg':jpg!.imageUrl!,   //"!.toMap()"->para que llame al to map de la clase Jpg
    };
  }

  Images.fromMap(Map<String, dynamic> map) {
    jpg = map['jpg'] != null ? Jpg.fromMap(map['jpg']) : null;
  }

}

class Jpg {
  String? imageUrl;

  Jpg(this.imageUrl);

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

  Jpg.fromMap(Map<String, dynamic> map) {
    imageUrl = map['imageUrl'];
  }

}
