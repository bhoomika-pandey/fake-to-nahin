class UserModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String _id;
  String _email;
  String _username;
  String _firstName;
  String _lastName;
  String _country;
  String _state;
  String _city;
  String _mobile;
  String _password;
  String _imagePath;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  // UserModel(this._email, this._username, this._firstName, this._lastName,
  //     this._country, this._state, this._city, this._mobile, this._password,
  //     [this._imagePath]);

  UserModel();
  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  UserModel.withId(
      this._id,
      this._email,
      this._username,
      this._firstName,
      this._lastName,
      this._country,
      this._state,
      this._city,
      this._mobile,
      this._password,
      [this._imagePath]);

  // Getters
  String get id => _id;
  String get email => _email;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get country => _country;
  String get state => _state;
  String get city => _city;
  String get mobile => _mobile;
  String get password => _password;
  String get imagePath => _imagePath;

  set email(String email) {
    _email = email;
  }

  set username(String username) {
    _username = username;
  }

  set firstName(String firstName) {
    _firstName = firstName;
  }

  set lastName(String lastName) {
    _lastName = lastName;
  }

  set country(String country) {
    _country = country;
  }

  set state(String state) {
    _state = state;
  }

  set city(String city) {
    _city = city;
  }

  set mobile(String mobile) {
    _mobile = mobile;
  }

  set password(String password) {
    _password = password;
  }

  set imagePath(String imagePath) {
    _imagePath = imagePath;
  }

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["email"] = _email;
    map["username"] = _username;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["country"] = _country;
    map["state"] = _state;
    map["city"] = _city;
    map["mobile"] = _mobile;
    map["password"] = _password;
    map["imagePath"] = _imagePath;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  UserModel.fromObject(dynamic o) {
    this._id = o["id"];
    this._email = o["email"];
    this._username = o["username"];
    this._firstName = o["firstName"];
    this._lastName = o["lastName"];
    this._country = o["country"];
    this._state = o["state"];
    this._city = o["city"];
    this._mobile = o["mobile"];
    this._password = o["password"];
    this._imagePath = o["imagePath"];
  }
}
