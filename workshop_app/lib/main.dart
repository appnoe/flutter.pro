import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:loggy/loggy.dart';
import 'api/api.dart';
import 'package:workshop_app/model/tvmazesearchresult.dart';
import 'package:workshop_app/view/show_details.dart';
import 'package:workshop_app/platform_channel/cryptokit.dart';
import 'package:async/async.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  static CryptoKit cryptoKit = CryptoKit();
  String searchString = 'simpsons';
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var apiData = <TVMazeSearchResult>[];
  bool _isOn = true;

  @override
  void initState() {
    super.initState();
    cryptoKit.getHash('simpsons');
    _loadData(searchString);
  }

  Future<bool> _loadDataWithoutSearchText() async {
    return _loadData(searchString);
  }

  bool _loadData(String searchText) {
    _memoizer.runOnce(() async {
      var result = Api().fetchShow(searchText);
      result.then((value) {
        apiData = value!;
        setState(() {
          rows = buildTableRows(value);
        });
        return true;
      });
    });

    return true;
  }

  Show? _showWithID(int id) {
    for (var i = 0; i < apiData.length; i++) {
      if (apiData[i].show?.id == id) {
        return apiData[i].show;
      }
    }
    return null;
  }

  void _toggle() {
    logDebug('_toggle');
    setState(() {
      _isOn = !_isOn;
    });
  }

  void _onTapImage(int id) {
    logDebug("onTapImage: $id");
    var show = _showWithID(id);
    if (show != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowDetails(show: show);
      }));
    }
  }

  List<TableRow> buildTableRows(List<TVMazeSearchResult>? shows) {
    var rows = <TableRow>[];
    shows?.forEach((element) {
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
        appBar: AppBar(centerTitle: true, title: Text("TITLE"), actions: [
          PlatformSwitch(
              activeColor: Colors.black,
              value: _isOn,
              onChanged: (val) {
                _toggle();
                setState(() {
                  _isOn = val;
                });
              }),
        ]),
        // AppBar(
        //   title: Text(widget.title),
        //   leading: GestureDetector(
        //     onTap: () {
        //       _displayTextInputDialog(context);
        //     },
        //     child: const Icon(
        //       Icons.search, // add custom icons also
        //     ),
        //   ),
        // ),
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
