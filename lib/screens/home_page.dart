import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsiv_login_page_flutter/http_services/home_page_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int tabIndex = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/icon.png"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: tabIndex == 0
                ? HomePageWidget()
                : tabIndex == 1
                    ? PostPageWidget()
                    : LogOutWidget(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.redAccent,
                ),
                backgroundColor: Colors.redAccent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded, color: Colors.black),
                activeIcon: Icon(
                  Icons.add_box_rounded,
                  color: Colors.redAccent,
                ),
                backgroundColor: Colors.redAccent,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ),
                label: '',
              )
            ],
            currentIndex: tabIndex,
            selectedItemColor: Colors.redAccent,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
              });
            },
          ),
        ));
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late List getAllPost;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAllPostMethod();
    });
  }

  void getAllPostMethod() async {
    getAllPost = await HomePageService().getAllPost();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? SpinKitSpinningLines(
      color: Colors.redAccent,
      size: 100,
      duration: Duration(seconds: 3),
    )
        : ListView.builder(
            itemCount: getAllPost.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: getAllPost[index]["Color"], width: 7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    getAllPost[index]["VirtualName"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      getAllPost[index]["TextContent"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    getAllPost[index]["DateCreated"],
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
                          "${getAllPost[index]["Likes"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                        FaIcon(
                          FontAwesomeIcons.heartBroken,
                          size: 40,
                        ),
                        Text(
                          "${getAllPost[index]["Dislikes"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(
                          Icons.comment,
                          size: 40,
                        ),
                        Text(
                          "${getAllPost[index]["CommentCount"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class PostPageWidget extends StatelessWidget {
  const PostPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This is the Post Page"),
      ],
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This is the Exit Page"),
      ],
    );
  }
}
