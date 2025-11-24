class StatusUpdate {
  final String id;
  final String category;
  final String description;
  final String createdAt;
  final String project;

  StatusUpdate({required this.id, required this.category, required this.description, required this.createdAt, required this.project});

  factory StatusUpdate.fromJson(Map<String, dynamic> json) {
    return StatusUpdate(
      id: (json['id'] ?? '').toString(),
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      project: json['project'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'category': category,
    'description': description,
    'createdAt': createdAt,
    'project': project,
  };
}
