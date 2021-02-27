import 'package:stack_overflow_vilash/utility/network/generic_model.dart';

class QuestionListDataModel extends GenericModel{
  List<QuestionDm> questions;
  bool hasMore;
  int quotaMax;
  int quotaRemaining;

  QuestionListDataModel({this.questions, this.hasMore, this.quotaMax, this.quotaRemaining});

  QuestionListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      questions = new List<QuestionDm>();
      json['items'].forEach((v) {
        questions.add(new QuestionDm.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['items'] = this.questions.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this.hasMore;
    data['quota_max'] = this.quotaMax;
    data['quota_remaining'] = this.quotaRemaining;
    return data;
  }

  @override
  from(json) {
    return QuestionListDataModel.fromJson(json);
  }
}

class QuestionDm {
  List<String> tags;
  Owner owner;
  bool isAnswered;
  int viewCount;
  int answerCount;
  int score;
  int lastActivityDate;
  int creationDate;
  int questionId;
  String contentLicense;
  String link;
  String title;
  int acceptedAnswerId;
  int lastEditDate;

  QuestionDm(
      {this.tags,
        this.owner,
        this.isAnswered,
        this.viewCount,
        this.answerCount,
        this.score,
        this.lastActivityDate,
        this.creationDate,
        this.questionId,
        this.contentLicense,
        this.link,
        this.title,
        this.acceptedAnswerId,
        this.lastEditDate});

  QuestionDm.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isAnswered = json['is_answered'];
    viewCount = json['view_count'];
    answerCount = json['answer_count'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
    link = json['link'];
    title = json['title'];
    acceptedAnswerId = json['accepted_answer_id'];
    lastEditDate = json['last_edit_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags'] = this.tags;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['is_answered'] = this.isAnswered;
    data['view_count'] = this.viewCount;
    data['answer_count'] = this.answerCount;
    data['score'] = this.score;
    data['last_activity_date'] = this.lastActivityDate;
    data['creation_date'] = this.creationDate;
    data['question_id'] = this.questionId;
    data['content_license'] = this.contentLicense;
    data['link'] = this.link;
    data['title'] = this.title;
    data['accepted_answer_id'] = this.acceptedAnswerId;
    data['last_edit_date'] = this.lastEditDate;
    return data;
  }
}

class Owner {
  int reputation;
  int userId;
  String userType;
  String profileImage;
  String displayName;
  String link;

  Owner(
      {this.reputation,
        this.userId,
        this.userType,
        this.profileImage,
        this.displayName,
        this.link});

  Owner.fromJson(Map<String, dynamic> json) {
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reputation'] = this.reputation;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    data['link'] = this.link;
    return data;
  }
}
