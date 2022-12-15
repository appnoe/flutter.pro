import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:loggy/loggy.dart';
import 'api/api.dart';
import 'model/tvmazesearchresult.dart' as _model;
import 'package:async/async.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Die App zum Workshop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var rows = <TableRow>[];
  String searchString = 'simpsons';
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    // _title = getValue();
    _loadData(searchString);
  }

  Future<bool> _loadDataWithoutSearchText() async {
    return _loadData(searchString);
  }

  bool _loadData(String searchText) {
    _memoizer.runOnce(() async {
      var apiData = Api().fetchShow(searchText);
      apiData.then((value) {
        setState(() {
          rows = buildTableRows(value);
        });
        return true;
      });
    });

    return true;
  }

  void _onTapImage(int id) {
    logDebug("onTapImage: $id");
  }

  List<TableRow> buildTableRows(List<_model.TVMazeSearchResult>? shows) {
    var rows = <TableRow>[];
    shows?.forEach((element) {
      logDebug('Image url: $element.show!.image!.medium!');
      if (element.show!.image != null) {
        var row = TableRow(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
                child: GestureDetector(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: element.show!.image!.medium!,
                    ),
                    onTap: () {
                      _onTapImage(element.show!.id!);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 8.0, right: 0.0, bottom: 12.0),
                child: Text(element.show!.name!),
              )
            ],
          )
        ]);
        rows.add(row);
      }
    });
    if (shows != null) {
      for (var i = 0; i < shows.length; i++) {}
      // better use this old style for loop instead of .forEach
      // see https://itnext.io/comparing-darts-loops-which-is-the-fastest-731a03ad42a2
    }

    return rows;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
                    _loadData(searchString);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
            onTap: () {
              _displayTextInputDialog(context);
            },
            child: const Icon(
              Icons.search, // add custom icons also
            ),
          ),
        ),
        body: FutureBuilder<bool>(
          future: _loadDataWithoutSearchText(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Table(
                  children: rows,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
