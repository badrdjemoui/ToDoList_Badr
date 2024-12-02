import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

// تطبيق Todo
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شريط الديباغ
      home: TodoScreen(), // الشاشة الرئيسية
    );
  }
}

// شاشة المهام الرئيسية
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _todos = []; // قائمة المهام
  final TextEditingController _controller = TextEditingController(); // للتحكم في النص

  // إضافة مهمة جديدة
  void _addTodo(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _todos.add({
          'id': DateTime.now().toString(), // معرف فريد لكل مهمة
          'title': title, // عنوان المهمة
          'isCompleted': false, // حالة المهمة (غير مكتملة)
        });
      });
      _controller.clear(); // مسح النص بعد الإضافة
    }
  }

  // تغيير حالة المهمة
  void _toggleTodoStatus(String id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo['id'] == id);
      todo['isCompleted'] = !todo['isCompleted'];
    });
  }

  // حذف مهمة
  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المهام'), // عنوان التطبيق
      ),
      body: Column(
        children: [
          // مربع إدخال النص
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'أضف مهمة جديدة', // نص إرشادي
                suffixIcon: IconButton(
                  icon: Icon(Icons.add), // زر الإضافة
                  onPressed: () => _addTodo(_controller.text),
                ),
              ),
            ),
          ),
          // قائمة المهام
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(
                    todo['title'],
                    style: TextStyle(
                      decoration: todo['isCompleted']
                          ? TextDecoration.lineThrough // خط على النص إذا اكتملت
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo['isCompleted'],
                    onChanged: (_) => _toggleTodoStatus(todo['id']),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red), // زر الحذف
                    onPressed: () => _deleteTodo(todo['id']),
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
