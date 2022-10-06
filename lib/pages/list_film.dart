import 'package:flutter/material.dart';
import 'package:movie_app/pages/description.dart';
import 'package:movie_app/text_with_style.dart';
import 'package:tmdb_api/tmdb_api.dart';


class ListFilm extends StatefulWidget {
  const ListFilm({super.key});
  @override
  _ListFilm createState() =>  _ListFilm();

}

class _ListFilm extends State<ListFilm> {
  List filmaffiche = [];// Liste de film à l'affiche
  final String apikey = 'b99885f31608ec14c703d0f1f82696e8'; // clé API
  final accesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOTk4ODVmMzE2MDhlYzE0YzcwM2QwZjFmODI2OTZlOCIsInN1YiI6IjYzMzZjZWJjY2JhMzZmMDA3YzU5YjJiYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LJSj_5WZZetRvjTq4Es7Y48Q27qYTep2Sz-oQod0Lvw';// Token

  // Initialisation de l'application
  @override
  void initState() {
    super.initState();
    chargefilm();
  }
  // Récuperation de la liste de film les mieux notés
  chargefilm() async{
    TMDB tmdbLogs = TMDB(ApiKeys(apikey, accesstoken),logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true));
    Map afficheresult = await tmdbLogs.v3.movies.getTopRated();

    setState(() {
      filmaffiche = afficheresult['results'];
    });
    //print(filmaffiche);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: const Text('Film à l\'affiche'),
        ),
        body: ListView.builder(itemCount: 10,itemBuilder: (BuildContext context, int index) {
          Description desc = Description(nom: filmaffiche[index]['title'], description: filmaffiche[index]['overview'], posterurl: 'http://image.tmdb.org/t/p/w500'+filmaffiche[index]['poster_path'], date: filmaffiche[index]['release_date']); // Objet description contenant les informations d'un film
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Description(nom: desc.nom, description: desc.description, posterurl: desc.posterurl, date: desc.date,)));
            },
            child: Card(
              margin:  const EdgeInsets.only( top: 20, left: 5, right: 4.5),
              elevation: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        width: 100,
                        image: NetworkImage(desc.posterurl,
                        )
                    )
                    ,
                    Padding(
                      padding: const EdgeInsets.only(left: 5,bottom: 80),
                      child:  information(index: index, dec: desc),
                    ),
                  ],
                ),
              ),
            ),
          );
        })
    );
  }

  // Récupération des informations d'un film sous forme de colonne
  Column information({required int index, required Description dec}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10,),
        TextWithStyle(data: dec.nom, weight: FontWeight.bold, size: 15,),
        const SizedBox(height: 5,),
        TextWithStyle(data: dec.date, color: Colors.grey,),
        const SizedBox(height: 5,),
        TextWithStyle(data: dec.description.substring(0,50), size: 12, maxLines: 2,)
      ],
    );
  }
}








