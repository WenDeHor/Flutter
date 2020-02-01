class Project {
  final String imageUrl;
  final String alt_description;
  final String name;

  Project._({this.imageUrl, this.alt_description, this.name});
//TODO HOMEWORK
//  Приложение должно содержать два экрана:
//  * Список
//  - мини изображение с названием и автором
//  - когда пользователь нажимает на изображение, открывается экран фотографии
//  * Фотография
//  - отображает одну фотографию с максимальной площадью.
//
  factory Project.fromJson(Map<String, dynamic> json) {
    return new Project._(
      imageUrl: json['urls, small'],
      alt_description: json['alt_description'],
      name: json['user, first_name'],
    );
  }
}
