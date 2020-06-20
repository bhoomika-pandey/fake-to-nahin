class PostModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  int _id;
  String _title;
  String _description;
  String _dateCreated;
  String _username;
  String _imagePath;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  PostModel(this._title, this._username, this._dateCreated,
      this._description, this._imagePath);

  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  PostModel.withId(this._id, this._title, this._username, this._dateCreated,
      this._description, this._imagePath);

  // Getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get dateCreated => _dateCreated;
  String get username => _username;
  String get imagePath => _imagePath;

  //  Setters
  set title(String newTitle) {
    _title = newTitle;
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set dateCreated(String newDate) {
    _dateCreated = newDate;
  }

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["username"] = _username;
    map["dateCreated"] = _dateCreated;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  PostModel.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._username = o["username"];
    this._dateCreated = o["dateCreated"];
  }
}
