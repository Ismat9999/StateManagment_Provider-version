

import 'package:flutter/cupertino.dart';
import 'package:smprovider/data/datasources/remote/http_service.dart';
import '../models/random_user_list_res.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<RandomUser> userList = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  loadRandomUserList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_RANDOM_USER_LIST,
        Network.paramsRandomUserList(currentPage));
    var randomUserListRes = Network.parseRandomUserList(response!);
    currentPage = randomUserListRes.info.page + 1;

    userList.addAll(randomUserListRes.results);
    isLoading = false;
    notifyListeners();
  }
}