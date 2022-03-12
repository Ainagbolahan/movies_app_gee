import 'package:flutter/material.dart';
import 'package:movies_app_gee/widgets/cast_list_widget.dart';

import '../models/credits.dart';
import '../widgets/credits_lists_widget.dart';

class CastAndCrew extends StatelessWidget {
  final ThemeData? themeData;
  final Credits? credits;
  CastAndCrew({this.themeData, this.credits});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData!.primaryColor,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: themeData!.colorScheme.secondary,
            tabs: [
              Tab(
                child: Text(
                  'Cast',
                  style: themeData!.textTheme.bodyText1,
                ),
              ),
              Tab(
                child: Text(
                  'Crew',
                  style: themeData!.textTheme.bodyText1,
                ),
              ),
            ],
          ),
          title: Text(
            'Cast And Crew',
            style: themeData!.textTheme.headline5,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: themeData!.colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(
          children: [
            CastList(
              credits: credits,
              themeData: themeData,
            ),
            CreditsList(
              credits: credits,
              themeData: themeData,
            )
          ],
        ),
      ),
    );
  }
}
