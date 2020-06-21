import 'package:fake_to_nahin/models/ResourceModel.dart';

class PostModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String _id;
  String _title;
  String _description;
  String _dateCreated;
  String _username;
  String _mediaPath;
  List<ResourceModel> _resources;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  PostModel(this._title, this._username, this._dateCreated, this._description,
      this._mediaPath,
      [this._resources]);

  // PostModel();
  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  PostModel.withId(this._id, this._title, this._username, this._dateCreated,
      this._description, this._mediaPath, this._resources);

  // Getters
  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get dateCreated => _dateCreated;
  String get username => _username;
  String get mediaPath => _mediaPath;
  List<ResourceModel> get resources => _resources;

  //  Setters
  set title(String title) {
    _title = title;
  }

  set id(String id) {
    _id = id;
  }

  set description(String description) {
    _description = description;
  }

  set dateCreated(String dateCreated) {
    _dateCreated = dateCreated;
  }

  set username(String username) {
    _username = username;
  }

  set mediaPath(String mediaPath) {
    _mediaPath = mediaPath;
  }

  set resources(List<ResourceModel> resources) {
    _resources = new List<ResourceModel>.from(resources);
  }

  // method to transform out Todo Stringo a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["username"] = _username;
    map["dateCreated"] = _dateCreated;
    map["mediaPath"] = _mediaPath;

    if (_id != null) {
      map["id"] = _id;
    }

    if (_resources != null) {
      map["resources"] = _resources;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it Stringo a Todo
  PostModel.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._username = o["username"];
    this._dateCreated = o["dateCreated"];
    this._mediaPath = o["mediaPath"];
    this._resources = o["resources"];
  }
}
