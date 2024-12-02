import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart'; // استيراد مزود المهام
import 'todo_screen.dart'; // استيراد واجهة التطبيق

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()), // تسجيل المزود
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شعار الديباغ
      title: 'Todo List with Provider', // اسم التطبيق
      theme: ThemeData(primarySwatch: Colors.blue), // تخصيص اللون الأساسي
      home: TodoScreen(), // الشاشة الرئيسية
    );
  }
}
