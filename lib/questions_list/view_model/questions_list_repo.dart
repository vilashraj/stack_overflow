import 'package:stack_overflow_vilash/utility/custom_pagination/custom_pagination_repo.dart';

import '../questions_list_exports.dart';


class QuestionsListRepo extends CustomPaginationRepo{
  QuestionsListProvider questionsListProvider = QuestionsListProvider();

  @override
  Future fetchPaginationData({data, int page, int noOfRecords}) {
    return questionsListProvider.fetchQuestionsListList(data: data, page: page, noOfRecords: noOfRecords);
  }
}