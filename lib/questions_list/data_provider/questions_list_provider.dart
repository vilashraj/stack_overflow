import 'package:stack_overflow_vilash/questions_list/data_provider/question_list_data_model.dart';
import 'package:stack_overflow_vilash/questions_list/data_provider/question_list_request_model.dart';
import 'package:stack_overflow_vilash/utility/network/api_call.dart';
import 'package:stack_overflow_vilash/utility/network/end_points.dart';

class QuestionsListProvider {
    Future fetchQuestionsListList({data, int page, int noOfRecords}) async {

      QuestionListDataModel questionList;
      QuestionListRequestModel requestParameters = QuestionListRequestModel(
        order: "desc",
        page: page,
        pagesize: noOfRecords,
        site: 'stackoverflow',
        sort: 'activity'
      );
      var response = await ApiCall().call(
          method: RequestMethod.GET,
          apiCallType: ApiCallType.SIMPLE,
          endPoint: EndPoints.questions,
          apiPath: EndPoints.questions,
          parameters: requestParameters.toJson(),
          directResponse: true
          ,fullResponse: true);

      questionList = QuestionListDataModel.fromJson(response);
      return questionList.questions;
  }
}



