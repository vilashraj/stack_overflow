
class QuestionListRequestModel {
  int page;
  int pagesize;
  String order;
  String sort;
  String site;

  QuestionListRequestModel({this.page, this.pagesize, this.order, this.sort, this.site});

  QuestionListRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pagesize = json['pagesize'];
    order = json['order'];
    sort = json['sort'];
    site = json['site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pagesize'] = this.pagesize;
    data['order'] = this.order;
    data['sort'] = this.sort;
    data['site'] = this.site;
    return data;
  }
}
