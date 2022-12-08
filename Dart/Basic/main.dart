void main(List<String> args) {
  // function with parameters
  print(userInfo("Franz", 42));
  // function with optional parameters
  print(userInfoWithState("Joe", 23, true));
  // function with optional parameters
  print(userInfoWithState("Jane", 24));

  // function with parentheses
  print(yesOrNo(1));

  // function with with arrow syntax
  print(yesOrNoArrow(1));
}

// function with parameters
String userInfo(String name, int age) {
  return "$name is $age years old";
}

// function with optional parameters
String userInfoWithState(String name, int age, [bool? isOnline]) {
  if (isOnline != null) {
    return "$name is $age years old (🟢)";
  } else {
    return "$name is $age years old (🔴)";
  }
}

// function with parentheses
bool yesOrNo(int a) {
  if (a == 1) {
    return true;
  } else {
    return false;
  }
}

// function with arrow syntax
bool yesOrNoArrow(int a) => (a == 1) ? true : false;
