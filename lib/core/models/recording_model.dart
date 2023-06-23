import 'dart:io';

class RecordingData {
  final Directory appDirectory;
  final int? index;
  final String? path;

  RecordingData({
    required this.appDirectory,
    this.index,
    this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'appDirectory': appDirectory.path,
      'index': index,
      'path': path,
    };
  }

  factory RecordingData.fromJson(Map<String, dynamic> json) {
    return RecordingData(
      appDirectory: Directory(json['appDirectory']),
      index: json['index'],
      path: json['path'],
    );
  }
}
