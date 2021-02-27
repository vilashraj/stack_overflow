

class CustomEvent {}

class FetchData extends CustomEvent {

  var data;

  FetchData({this.data});
}
class RefreshData extends CustomEvent{
  var data;

  RefreshData({this.data});
}
class CustomEmptyEvent extends CustomEvent {}
