import 'package:flutter/material.dart';
import 'todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Using the Todo class instead of Maps
  final List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem(String taskName) {
    if (taskName.isNotEmpty) {
      setState(() {
        _todos.add(Todo(name: taskName));
      });
      _textController.clear();
    }
    Navigator.of(context).pop();
  }

  void _handleTodoChange(int index) {
    setState(() {
      _todos[index].isChecked = !_todos[index].isChecked;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Input a new task',
          ),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "Input task here"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () => _addTodoItem(_textController.text),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Planner', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _todos.isEmpty
          ? const Center(child: Text('No Tasks Yet.'))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  todo: _todos[index],
                  onChanged: () => _handleTodoChange(index),
                  onDelete: () => _deleteTodoItem(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}