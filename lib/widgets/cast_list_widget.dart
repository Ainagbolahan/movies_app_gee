import 'package:flutter/material.dart';

import '../constants/api_constants.dart';
import '../models/credits.dart';

class CastList extends StatelessWidget {
  CastList({required this.credits, required this.themeData});

  final ThemeData? themeData;
  final Credits? credits;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      color: themeData!.primaryColor,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: credits!.cast!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: credits!.cast![index].profilePath == null
                        ? Image.asset(
                            'assets/images/na.jpg',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'w500/' +
                                credits!.cast![index].profilePath!),
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name : ' + credits!.cast![index].name!,
                          style: themeData!.textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Character : ' + credits!.cast![index].character!,
                          style: themeData!.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
