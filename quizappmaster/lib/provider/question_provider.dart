import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizappmaster/model/question.dart';
import 'package:quizappmaster/service/api_service.dart';


class QuestionProvider with ChangeNotifier {
  var api = API_Service();
  late List<Question> listQuestion;
  late bool isLoading;
  late String error;
  late int currentIndex;
  late Map<int,dynamic> answer;

  void initValue(){
    api = API_Service();
    listQuestion = [];
     isLoading = false;
     error = '';
     currentIndex = 0;
    answer = {};
  }

  Future<List<Question>> getDataQuestion(String difficulty,int totalQuestion,int categoriesId) async {

    String url = "${api.baseURL}?amount=$totalQuestion&category=$categoriesId&difficulty=$difficulty";
    var dio = Dio();
    isLoading = true;
    print(url);
    try {
      var res = await dio.get(url);
      if (res.statusCode == 200) {
        var jsonData = res.data;
        for (var i in jsonData['results']) {
          listQuestion.add(Question.fromJson(i));
        }
      }
      if (res.statusCode == 1) {

      }
    } on DioError catch (e){
      print(e.error);
      print(e.request);
      print(e.type);
    }

    isLoading =false;
    notifyListeners();
    return listQuestion;
  }

  void selectRadio(dynamic e){
      answer[currentIndex] = e;
      notifyListeners();
      return;
  }

  void selectQuestion(dynamic e){
    currentIndex = e;
    notifyListeners();
  }

  Future<void> submitQuiz(List<Question> listQuestion) async {
    if (currentIndex < (listQuestion.length - 1) ) {
      currentIndex ++;
      notifyListeners();
    }
    notifyListeners();
  }

  void isLoadingg(bool status){
    isLoading = status;
    notifyListeners();
  }
}