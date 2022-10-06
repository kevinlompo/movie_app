import 'package:flutter/material.dart';
import 'package:movie_app/text_with_style.dart';

class Description extends StatelessWidget {

  final String nom, description,  posterurl, date;

  const Description({super.key, required this.nom, required this.description, required this.posterurl, required this.date});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: TextWithStyle(data: nom, size: 20, weight: FontWeight.w500,style: FontStyle.italic,),
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextWithStyle(data: nom, weight: FontWeight.bold,
                        size: 20 ,),
                    ),
                    Image.network(posterurl, height: 200, width: 200,),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: Center(
                        child: Text(date),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20),
                      alignment: Alignment.topLeft,
                      child: TextWithStyle(data: 'Sypnopsis', weight: FontWeight.bold,
                        size: 20,),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20),
                      alignment: Alignment.topLeft,
                      child: TextWithStyle(data: description, maxLines: description.length,),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}