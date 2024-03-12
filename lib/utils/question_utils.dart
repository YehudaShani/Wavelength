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
