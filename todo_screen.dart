import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart'; // استيراد مزود المهام

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(); // التحكم بحقل النص

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context); // الوصول إلى المزود

    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المهام'), // عنوان التطبيق
      ),
      body: Column(
        children: [
          // إدخال مهمة جديدة
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'أضف مهمة جديدة', // نص الإرشاد
                suffixIcon: IconButton(
                  icon: Icon(Icons.add), // زر الإضافة
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      todoProvider.addTodo(_controller.text); // إضافة المهمة
                      _controller.clear(); // مسح النص
                    }
                  },
                ),
              ),
            ),
          ),
          // عرض قائمة المهام
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.todos.length, // عدد المهام
              itemBuilder: (context, index) {
                final todo = todoProvider.todos[index]; // المهمة الحالية
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough // خط على النص إذا كانت مكتملة
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted, // حالة المهمة
                    onChanged: (_) => todoProvider.toggleTodoStatus(todo.id), // تغيير الحالة
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red), // زر الحذف
                    onPressed: () => todoProvider.deleteTodo(todo.id), // حذف المهمة
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
