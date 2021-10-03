import 'package:get/get.dart';


class PostsController extends GetxController {
  var posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    return;
  }
}
