import 'package:flutter/material.dart';
import 'todo.dart'; // استيراد نموذج Todo

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = []; // قائمة المهام

  List<Todo> get todos => _todos; // طريقة للوصول إلى قائمة المهام

  // إضافة مهمة جديدة
  void addTodo(String title) {
    _todos.add(Todo(id: DateTime.now().toString(), title: title));
    notifyListeners(); // إشعار كل من يستمع للتحديث
  }

  // تغيير حالة المهمة (مكتملة/غير مكتملة)
  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.isCompleted = !todo.isCompleted; // تغيير الحالة
    notifyListeners(); // إشعار المستمعين
  }

  // حذف مهمة
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id); // حذف المهمة
    notifyListeners(); // إشعار المستمعين
  }
}
