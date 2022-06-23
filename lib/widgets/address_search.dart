// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:transportation/utils/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider? apiClient;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        tooltip: 'Clear',
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      tooltip: 'Back',
      onPressed: () {
        close(context, Suggestion()); //kemungkinan
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Offstage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List>(
      future: query == ""
          ? null
          : apiClient?.fetchSuggestion(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) {
        var snapdata = snapshot.data;

        if (query == '') {
          return Container(
            padding: EdgeInsets.all(16),
            child: Text("Masukkan Alamat"),
          );
        } else {
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text((snapdata![index] as Suggestion).description),
                      onTap: () {
                        close(context, snapdata[index] as Suggestion);
                      },
                    );
                  },
                  itemCount: snapdata?.length,
                )
              : Text("loading. . .");
        }
      },
    );
  }
}
