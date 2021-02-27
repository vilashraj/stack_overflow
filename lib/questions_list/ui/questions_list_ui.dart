import 'package:stack_overflow_vilash/question_detail/question_detail.dart';
import 'package:stack_overflow_vilash/questions_list/data_provider/question_list_data_model.dart';
import 'package:stack_overflow_vilash/utility/base/base_circular_progress_indicator.dart';
import 'package:stack_overflow_vilash/utility/constants/string_constants.dart';
import 'package:stack_overflow_vilash/utility/custom_pagination/custom_pagination_bloc.dart';
import 'package:stack_overflow_vilash/utility/custom_pagination/custom_pagination_event.dart';
import 'package:stack_overflow_vilash/utility/custom_pagination/custom_pagination_state.dart';

import '../questions_list_exports.dart';




class QuestionsListListUI extends StatefulWidget {
  QuestionsListListUI({Key key}) : super(key: key);

  @override
  _QuestionsListListUIState createState() => _QuestionsListListUIState();
}

class _QuestionsListListUIState extends State<QuestionsListListUI> {

  //controllers:
  ScrollController questionsListListScrollController;

  //blocs:
  CustomPaginationBloc questionsListBloc;

  //variables:
  final _scrollThreshold = 400.0;


  @override
  void initState() {
    super.initState();
    questionsListBloc = CustomPaginationBloc(
        CustomPaginationDataUninitialized(),
        customPaginationRepo: QuestionsListRepo());
    questionsListListScrollController = ScrollController();
    questionsListBloc.add(FetchPaginationDataList(
        data: {}));
    questionsListListScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    questionsListListScrollController.dispose();
    questionsListBloc.close();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = questionsListListScrollController.position.maxScrollExtent;
    final currentScroll = questionsListListScrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      questionsListBloc.add(FetchPaginationDataList(
          data: {}));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text("Questions"),
      actions: [],
    );
  }

  Widget getBody() {
    return  BlocBuilder(
        cubit: questionsListBloc,
        builder: (context, CustomPaginationState state) {
          if(state is CustomPaginationDataLoading){
            return getLoadingWidget();
          }
          if (state is CustomPaginationDataLoaded) {
            return questionsListWidget(state);
          }

          else if (state is CustomPaginationDataError) {
            return getErrorWidget(state);
          }

          else if (state is CustomPaginationDataEmpty) {
            return getEmptyWidget();
          }

          return Container();
        });
  }

  Widget getLoadingWidget() {
    return Center(
        child: CircularProgressIndicator()
    );
  }

  Widget getErrorWidget(CustomPaginationDataError state) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.errorText, textAlign: TextAlign.center),
          FlatButton(
              onPressed: () {
                questionsListBloc.add(FetchPaginationDataList());
              },
              child: Icon(
                Icons.refresh,
              ))
        ]
    );
  }

  Widget getEmptyWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(StringConstants.noResultsFound, textAlign: TextAlign.center),
          FlatButton(
              onPressed: () {
                questionsListBloc.add(FetchPaginationDataList());
              },
              child: Icon(
                Icons.refresh,
              ))
        ]
    );
  }

  Widget questionsListWidget(CustomPaginationDataLoaded state) {
    return ListView.separated(
      separatorBuilder: (context, position){
        return Divider();
      },
        controller: questionsListListScrollController,
        itemCount: state.hasReachedMax
            ? state.dataList.length
            : state.dataList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index >= state.dataList.length
              ? BaseCircularProgressIndicator()
              :questionsListListItem(state.dataList[index]);

        }
    );
  }

  Widget questionsListListItem(QuestionDm item) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => QuestionDetail(url: item.link))
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           children: [
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Column(
                   children: [
                     Text(item.score.toString(), style: TextStyle(fontSize: 16.0),),
                     Text("votes", style: TextStyle(fontSize: 12.0),),
                     SizedBox(height: 8.0,),

                     Container(
                       decoration: BoxDecoration(
                         color: Colors.green[600],
                         borderRadius: BorderRadius.all(Radius.circular(5))
                       ),

                       child: Padding(
                         padding: const EdgeInsets.all(4.0),
                         child: Column(
                           children: [
                             Text(item.answerCount.toString(), style: TextStyle(fontSize: 16.0, color: Colors.white),),
                             Text("answers", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                           ],
                         ),
                       ),
                     )
                   ],
                 ),
                 SizedBox(width: 12.0,),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(item.title.toString(), style: TextStyle(fontSize: 15.0, color: Colors.blue[900]),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                       SizedBox(height: 16.0,),

                       Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                             crossAxisAlignment: WrapCrossAlignment.start,
                             spacing: 4.0,
                             runSpacing: 4.0,
                             children: getTags(item.tags),
                            ),
                          ),
                        ],
                      ),
                     ],
                   ),
                 ),
               ],
             )
           ],
          ),
        )
      ),
    );
  }

  List<Widget> getTags(List<String> tags){
    List<Widget> list = [];
    tags.forEach((i) {
      list.add(Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
                i,
              style: TextStyle(color: Colors.blueGrey),
            ),
          )
      ));
    });
    return list;
  }
}