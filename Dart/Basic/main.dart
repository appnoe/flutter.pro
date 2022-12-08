void main(List<String> args) {
  // typed list with integers
  var ints = [1, 2, 3, 4];
  ints.add(23);
  // assignement error
  // ints.add("foo");
  print(ints);

  // initialization of empty list
  var intList = <int>[];
  intList.add(23);
  intList.add(42);
  print(intList);

  // typed list with doubles
  var doubles = [23.5, 42.5];
  print(doubles);

  // traditional for loop
  for (var i = 0; i < ints.length; i++) {
    print(ints[i]);
  }

  // foreach loop
  ints.forEach((element) {
    element = element + 1;
    print("Element: $element");
  });

  // map: change list elements
  var quadInts = ints.map((e) => e * 2);
  print(quadInts);

  // mixed list
  var mixedList = [1, 2, 3, "d"];
  print(mixedList);
  mixedList.forEach((element) {
    // type error
    // element = element + 1;
    print("Element: $element");
  });

  // filter list with condition
  var characters = mixedList.where((element) => element is int);
  print(characters);
}
