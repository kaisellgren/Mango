import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;

var columns = [
    {'id': 'name', 'title': 'Name'},
    {'id': 'age', 'title': 'Age'},
    {'id': 'salary', 'title': 'Salary'},
    {'id': 'company', 'title': 'Company'},
    {'id': 'favorite-shows', 'title': 'Favorite TV shows'},
];

var rows = [
  {'name': 'Jack', 'age': 15, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Susan', 'age': 25, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Peter', 'age': 12, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Davit', 'age': 18, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Lukas', 'age': 35, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Yusif', 'age': 46, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Ivan', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Noah', 'age': 23, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Milan', 'age': 37, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Lucas', 'age': 53, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Nathan', 'age': 46, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Mohamed', 'age': 23, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Amar', 'age': 45, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Georgi', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Luka', 'age': 35, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Jakub', 'age': 65, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Victor', 'age': 25, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Harry', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Rasmus', 'age': 33, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Elias', 'age': 23, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Emil', 'age': 45, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Nathan', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Nika', 'age': 33, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Ben', 'age': 32, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Georgios', 'age': 23, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Malik', 'age': 25, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Charlie', 'age': 26, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Bence', 'age': 54, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Aron', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Agron', 'age': 15, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Spartacus', 'age': 56, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Crixus', 'age': 43, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Robert', 'age': 65, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Ben', 'age': 34, 'salary': 0, 'favorite-shows': 'Dexter'},
  {'name': 'Rubens', 'age': 54, 'salary': 0, 'favorite-shows': 'Dexter'},
];

main() {
}