class Poi extends SuperPoi {
  // getter + setter
  // var _placeholder = "Keine Angabe";
  // var _title;
  // var _subtitle;

  // Constructor
  Poi(
      {required String title,
      required String subtitle,
      double? lat,
      double? lon}) {
    this.title = title;
    this.subtitle = subtitle;
    this.lat = lat;
    this.lon = lon;
  }

  // setter
  // void set title(String title){
  //   if(title.length > 0) {
  //     _title = title;
  //   } else {
  //     _title = _placeholder;
  //   }
  // }

  // void set subtitle(String subtitle){
  //   if(subtitle.length > 0) {
  //     _subtitle = subtitle;
  //   } else {
  //     _subtitle = _placeholder;
  //   }
  // }

  // getter
  // String get title {
  //   return _title;
  // }

  // String get subtitle {
  //   return _subtitle;
  // }

  String get locationDescription {
    if (this.lat != null && this.lon != null) {
      return "$lat::$lon";
    } else {
      return "No location data available.";
    }
  }
}

abstract class SuperPoi {
  var title;
  var subtitle;
  double? lat;
  double? lon;
  String get locationDescription;
}
