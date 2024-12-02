class Todo {
  String id; // معرّف فريد لكل مهمة
  String title; // عنوان المهمة
  bool isCompleted; // حالة المهمة (هل اكتملت أم لا)

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false, // القيمة الافتراضية هي "غير مكتملة"
  });
}
