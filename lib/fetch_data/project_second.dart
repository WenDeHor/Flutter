class Project_second {
  final String url_full;

  Project_second._({this.url_full});

  factory Project_second.fromJson(Map<String, dynamic> json) {
    return new Project_second._(
      url_full: json['urls, full'],
    );
  }
}
