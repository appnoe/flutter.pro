import 'poi.dart';

void main(List<String> args) {
  // classes
  // Poi dom = Poi();
  // constructor
  Poi dom =
      Poi(title: "Dom", subtitle: "zu Köln", lat: 50.941278, lon: 6.958281);
  // dom.lat = 50.941278;
  // dom.lon = 6.958281;
  // dom.title = "Dom";
  // dom.subtitle = "zu Köln";
  print('Ort: ${dom.title} ${dom.subtitle}');
  print('Koordinaten: ${dom.locationDescription}');

  Poi meh = Poi(title: "Düsseldorf", subtitle: "jwd");
  // dom.lat = 50.941278;
  // dom.lon = 6.958281;
  // dom.title = "Dom";
  // dom.subtitle = "zu Köln";
  print('Ort: ${meh.title} ${meh.subtitle}');
  print('Koordinaten: ${meh.locationDescription}');
}
