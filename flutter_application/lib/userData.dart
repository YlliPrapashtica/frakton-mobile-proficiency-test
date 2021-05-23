import 'screens/singleUserData.dart';

class Users {
  Users(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});

  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserData> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      page: json["page"],
      perPage: json["per_page"],
      total: json["total"],
      totalPages: json["total_pages"],
      data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson()))
      };

  List<UserData> getFutureUser() {
    return this.data;
  }
}
