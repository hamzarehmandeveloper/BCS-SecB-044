class Score {
  late int id;
  late String nameUser;
  late  String categories;
  late  int score;
  late  String date;
  late  int totalAnswer;
  late  int totalQuestion;

  Score(
      {required this.id,
        required this.nameUser,
        required this.categories,
        required this.score,
        required this.date,
        required this.totalAnswer,
        required this.totalQuestion});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUser = json['nameUser'];
    categories = json['categories'];
    score = json['score'];
    date = json['date'];
    totalAnswer = json['totalAnswer'];
    totalQuestion = json['totalQuestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameUser'] = this.nameUser;
    data['categories'] = this.categories;
    data['score'] = this.score;
    data['date'] = this.date;
    data['totalAnswer'] = this.totalAnswer;
    data['totalQuestion'] = this.totalQuestion;
    return data;
  }
}