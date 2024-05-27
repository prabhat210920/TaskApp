class Task {
  final int? id;
  final String name;
  final String category;
  final String startDate;
  final String endDate;
  final String description;
  final String priority;
  final String status;

  Task({
    this.id,
    required this.name,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.priority,
    required this.status,
    // Initialize priority
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'priority': priority,
      'status': status// Include priority
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      description: map['description'],
      priority: map['priority'],
      status:  map['status'],
      // Parse priority
    );
  }

  Task copyWith({
    int? id,
    String? name,
    String? category,
    String? startDate,
    String? endDate,
    String? description,
    String? priority,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

}
