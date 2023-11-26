import 'package:anime_app/model/anime.dart';
import 'package:anime_app/repositories/anime_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/anime_service.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({super.key});

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {

  //variables
  AnimeService? _animeService;
  final _pageSize=25;
  final PagingController<int,Anime> _pagingController= PagingController(firstPageKey: 1);

  Future _fetchPage(int pageKey) async{

    try{
      //por cada llamada del metodo del servicio creo un arreglo de animes
      final animes=(await _animeService!.getAll(pageKey)).data as List<Anime>;

      //veo si el tamaño de animes es menor a 25, que el que quiero mostrar en cada paginacion
      final isLastPage=animes.length<_pageSize;

      if(isLastPage){ //si es menor a 25
        _pagingController.appendLastPage(animes); //muestro el arreglo
      }else{
        final nextPageKey=pageKey+1; //creo otra pagina
        //llamo al metod del servicio pasandole como parametro la pagina 2
        _pagingController.appendPage(animes, nextPageKey);
      }
    }catch(error){
      _pagingController.error=error;
    }
  }

  @override
  void initState(){
    //inicialiazo el servicio
    _animeService=AnimeService();
    //llamo a fetchpage
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PagedListView<int,Anime>(
      scrollDirection: Axis.vertical, //crea cada paginacion horizontalmente o vertical
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Anime>(
          itemBuilder: (context,item,index){
            return AnimeItem(anime:item); //cada indice de movies es un moviItem
          }
      ),
    );
  }
}

class AnimeItem extends StatefulWidget {

  const AnimeItem({super.key, required this.anime});

  //parametro
  final Anime anime;

  @override
  State<AnimeItem> createState() => _AnimeItemState();
}

class _AnimeItemState extends State<AnimeItem> {

  //atributos
  bool _add=false;
  AnimeRepository? _animeRepository;

  initialize()async{
    //_favorite toma el valor que da el metodo del repositorie al pasarle cada entidad
    _add=await _animeRepository?.isAdd(widget.anime)??false;
    if (mounted){ //si ya se cargo toda la informacion
      setState(() {
        _add=_add;
      });
    }
  }

  @override
  void initState(){
    _animeRepository=AnimeRepository();
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    //creo la imagen
    final image=Image.network(widget.anime.images!.jpg!.imageUrl!);

    final my_con= _add? const Icon(
      Icons.delete,color:Colors.blue,
    ):const Icon(
      Icons.add,color:Colors.blue,
    );

    return Card(
      child: ListTile(
        leading: image,
        title: Text(widget.anime.title!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TENER CUIDADO CON LOS ATRIBUTOS PORQUE PUEDEN SER NULOS!!!! AGREGAR VALIDACIONES
            Text('Year: ' + (widget.anime.year != null ? widget.anime.year!.toString() : 'Year is not defined')),
            Text(widget.anime.episodes != null ? widget.anime.episodes!.toString() : 'Episodes is not defined'),
            Text(widget.anime.members != null ? widget.anime.members!.toString() : 'Members is not defined'),

          ],
        ),
        trailing: IconButton(
          icon: my_con,
          //dentro del click
          onPressed: (){
            //_favorite cambia
            setState(() {
              _add=!_add;
            });
            //se agrega o elimina del repository
            //si es true lo insert, sino lo elimina
            _add?_animeRepository?.insert(widget.anime):_animeRepository?.delete(widget.anime);
          },
        ),
      ),
    );

  }
}








