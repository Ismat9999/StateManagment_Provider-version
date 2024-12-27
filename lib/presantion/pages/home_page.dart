import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smprovider/data/viewmodels/home_viewmodel.dart';
import '../../data/datasources/remote/http_service.dart';
import '../../data/models/random_user_list_res.dart';
import '../widgets/item_of_random_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel= HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadRandomUserList();
    viewModel.scrollController.addListener((){
      if (viewModel.scrollController.position.maxScrollExtent<=
      viewModel.scrollController.offset){
        viewModel.loadRandomUserList();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  const Text("Provider State"),
      ),
      body: ChangeNotifierProvider(
        create: (context)=> viewModel,
        child: Consumer<HomeViewModel>(
        builder: (ctx, model, index)=> Stack(
        children: [
        ListView.builder(
        controller: viewModel.scrollController,
        itemCount: viewModel.userList.length,
        itemBuilder: (ctx, index){
        return itemOfRandomUser(viewModel.userList[index], index);
        },
        ),
          viewModel.isLoading
          ? Center(
            child: CircularProgressIndicator(),
          ):const SizedBox.shrink(),
        ],
      ),
    ),
      ),
    );
  }
}
