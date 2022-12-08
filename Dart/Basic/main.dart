void main(List<String> args) {
  // explicitly typed
  String output = "Dart";
  print("Hello $output!");

  // type inference - done right
  var typeInference = "I'm a string"; // Change value, not type
  // typeInference = 23; // won't work
  print(typeInference);

/*
  // type inference - done wrong
  dynamic typeInferenceDynamic =
      "I'm a string"; // Change value and type - bad practice
  typeInferenceDynamic = 23;
  print(typeInferenceDynamic);
  typeInferenceDynamic++;
  print(typeInferenceDynamic);
  typeInferenceDynamic = 'foo';
  typeInferenceDynamic++;
  print(typeInferenceDynamic);
  */
}
