import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:workshop_app/features/showlist/presentation/bloc/show_list_bloc.dart';

import './show_details.dart';
import '../common/model/tvmazesearchresult.dart' as _model;

class ShowList extends StatefulWidget {
  static const titleKey = Key('ShowList.titleKey');
  static const errorKey = Key('ShowList.errorKey');

  const ShowList({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  var apiData = <_model.TVMazeSearchResult>[];
  String searchString = 'simpsons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          key: ShowList.titleKey,
        ),
        leading: GestureDetector(
          onTap: () {
            _displayTextInputDialog(context);
          },
          child: const Icon(
            Icons.search,
          ),
        ),
      ),
      body: BlocConsumer<ShowListBloc, ShowListState>(
        listenWhen: (previous, current) {
          return (current is ShowListFailure);
        },
        listener: (context, state) {
          print('cool, hat geklappt');
        },
        builder: (context, state) {
          if (state is ShowListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ShowListSuccess) {
            return SingleChildScrollView(
              child: Table(
                children: _buildTableRows(state.searchResult),
              ),
            );
          }
          if (state is ShowListFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.red,
                ),
                key: ShowList.errorKey,
              ),
            );
          }
          return const Center(
            child: Text(
              'Bitte deine Lieblingsserie suchen.',
            ),
          );
        },
      ),
    );
  }

  _model.Show? _showWithID(int id) {
    for (var i = 0; i < apiData.length; i++) {
      if (apiData[i].show?.id == id) {
        return apiData[i].show;
      }
    }
    return null;
  }

  void _onTapImage(int id) {
    if (kDebugMode) {
      print("onTapImage: $id");
    }
    var show = _showWithID(id);
    if (show != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowDetails(show: show);
      }));
    }
  }

  List<TableRow> _buildTableRows(List<_model.TVMazeSearchResult>? result) {
    var rows = <TableRow>[];
    result?.forEach((show) {
      var row = TableRow(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
              child: GestureDetector(
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: show.show!.image != null
                          ? show.show!.image!.medium!
                          : ''),
                  onTap: () {
                    _onTapImage(show.show!.id!);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
              child: Text(show.show!.name!),
            )
          ],
        )
      ]);
      rows.add(row);
    });

    return rows;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider<ShowListBloc>.value(
            value: BlocProvider.of<ShowListBloc>(context),
            child: AlertDialog(
              title: const Text('Suche nach Filmen'),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                decoration: const InputDecoration(hintText: "Suchbegriff"),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Abbrechen'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  child: const Text('Suchen'),
                  onPressed: () {
                    setState(() {
                      context.read<ShowListBloc>().add(
                            LoadSpecificMovie(movieName: searchString),
                          );
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
