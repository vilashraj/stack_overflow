

class CustomPaginationEvent {}

class FetchPaginationDataList extends CustomPaginationEvent {
  final String searchText;
  var data;

  FetchPaginationDataList({this.searchText, this.data});
}
