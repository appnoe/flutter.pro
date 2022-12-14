import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:loggy/loggy.dart';
import 'api/api.dart';
import 'model/tvmazesearchresult.dart' as Model;

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
  late Future<String> _title;

  @override
  void initState() {
    super.initState();
    _title = getValue();
    var apiData = Api().fetchShow('simpsons');
    apiData.then((value) {
      rows = buildTableRows(value);
    });
  }

  void onTapImage() {
    logDebug("onTapImage");
  }

  Future<String> getValue() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Flutter Devs';
  }

  List<TableRow> buildTableRows(List<Model.TVMazeSearchResult>? shows) {
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
                    onTap: onTapImage),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<String>(
          future: _title,
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
