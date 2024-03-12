// merge all questions and categories into one list

List<List<String>> makeQuestionList(Map<String, dynamic> questionsData) {
  final List<List<String>> questionList = [];
  for (var topic in questionsData['topics']) {
    for (var scale in questionsData['scales'][topic]) {
      questionList.add([topic, scale, ...questionsData['scaleValues'][scale]]);
    }
  }
  return questionList;
}

String getQuestionTopic(List<String> question) {
  return question[0];
}

String getQuestionScale(List<String> question) {
  return question[1];
}

String getQuestionBottomLabel(List<String> question) {
  return question[2];
}

String getQuestionTopLabel(List<String> question) {
  return question[3];
}
