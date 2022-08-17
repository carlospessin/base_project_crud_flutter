import 'package:base_project_crud/models/todo.dart';
import 'package:base_project_crud/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  String dataUrl = "https://jsonplaceholder.typicode.com";

  @override
  Future<String> deleteTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      return result = 'true';
    });

    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];

    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }

    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    String resData = '';
    var url = Uri.parse('$dataUrl/todos/${todo.id}');

    await http.patch(
      url,
      body: {
        'completed': (!todo.completed!).toString(),
      },
      headers: {'Authorization': 'yout_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['completed'];
    });

    return resData;
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    String resData = '';
    var url = Uri.parse('$dataUrl/todos/${todo.id}');

    await http.put(
      url,
      body: {
        'completed': (!todo.completed!).toString(),
      },
      headers: {'Authorization': 'yout_token'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['completed'];
    });

    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataUrl/todos/');
    var response = await http.post(url, body: todo.toJson());
    return 'true';
  }
}
