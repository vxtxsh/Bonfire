import 'package:flutter/cupertino.dart';

import 'package:mhealth2/diary/helpers/db_helper.dart';
import 'package:mhealth2/diary/helpers/mooddata.dart';
import 'package:mhealth2/diary/models/activity.dart';

class MoodCard extends ChangeNotifier {
  String datetime;
  String mood;
  List<String> activityname = [];
  List<String> activityimage = [];
  String image;
  String actimage;
  String actname;
  List items = [];
  List<MoodData> data = [];
  String date;
  bool isloading = false;
  List<String> actiname = [];

  MoodCard({
    required this.datetime,
    required this.mood,
    required this.image,
    required this.actimage,
    required this.actname,
    required this.date,
  });

  void add(Activity act) {
    activityimage.add(act.image);
    activityname.add(act.name);
    notifyListeners();
  }

  Future<void> addPlace(
    String datetime,
    String mood,
    String image,
    String actimage,
    String actname,
    String date,
  ) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'actimage': actimage,
      'actname': actname,
      'date': date
    });
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }
}
