import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsiv_login_page_flutter/http_services/home_page_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreen> {
  bool loading = true;
  List allPosts = [];
  int pageNumber = 1;
  bool buttonLoading = false;
  late List httpRequest;

  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      refreshPosts();
    });
    // if scroll's position at maxScrollExtent fetch new products(new page)
    _sc.addListener(() async {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        setState(() {
          buttonLoading = true;
        });
        await pullUpScreen();
        setState(() {
          buttonLoading = false;
        });
        // searchProductProvider.fetchData(widget.query);
      }
    });
  }

  Future<void> refreshPosts() async {
    setState(() {
      pageNumber = 1;
    });
    allPosts = await getNewestPosts(pageNumber);
  }

  Future<void> pullUpScreen() async {
    List get5Posts = await getNewestPosts(pageNumber + 1);
    if (get5Posts[0] == "No More Post") {
      setState(() {
        pageNumber = pageNumber;
      });
      return;
    } else {
      setState(() {
        for (var post in get5Posts) {
          allPosts.add(post);
        }
      });
      setState(() {
        pageNumber += 1;
      });
    }
  }

  Future<List> getNewestPosts(int pageNum) async {
    httpRequest = await HomePageService().getAllPost(pageNum);
    List get5Posts = httpRequest;
    setState(() {
      loading = false;
    });
    return get5Posts;
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: buttonLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/icon.png"),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: loading
            ? SpinKitSpinningLines(
                color: Colors.redAccent,
                size: 100,
                duration: Duration(seconds: 3),
              )
            : RefreshIndicator(
                onRefresh: refreshPosts,
                child: ListView.builder(
                  controller: _sc,
                  itemCount: allPosts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == allPosts.length) {
                      return _buildProgressIndicator();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border:
                            Border.all(color: allPosts[index]["Color"], width: 7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            allPosts[index]["VirtualName"],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: Text(
                              allPosts[index]["TextContent"],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            allPosts[index]["DateCreated"],
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                Text(
                                  "${allPosts[index]["Likes"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.heartBroken,
                                  size: 40,
                                ),
                                Text(
                                  "${allPosts[index]["Dislikes"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(
                                  Icons.comment,
                                  size: 40,
                                ),
                                Text(
                                  "${allPosts[index]["CommentCount"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
