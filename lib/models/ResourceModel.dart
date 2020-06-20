class ResourceModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String _id;
  String _dateCreated;
  String _username;
  String _link;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  ResourceModel(this._username, this._dateCreated, this._link);

  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  ResourceModel.withId(this._id, this._username, this._dateCreated, this._link);

  // Getters
  String get id => _id;
  String get dateCreated => _dateCreated;
  String get username => _username;
  String get link => _link;

  //  Setters
  set id(String id) {
    _id = id;
  }

  set dateCreated(String dateCreated) {
    _dateCreated = dateCreated;
  }

  set username(String username) {
    _username = username;
  }

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["dateCreated"] = _dateCreated;
    map["username"] = _username;
    map["link"] = _link;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  ResourceModel.fromObject(dynamic o) {
    this._id = o["id"];
    this._dateCreated = o["dateCreated"];
    this._username = o["username"];
    this._link = o["link"];
  }
}
