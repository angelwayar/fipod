import 'package:flutter/material.dart';
import 'package:fipod/widgets/album_card.dart';

import '../widgets/button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double currentpage = 1.0;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    );
    pageController.addListener(() {
      setState(() {
        currentpage = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 320.0,
              color: Colors.black,
              child: PageView.builder(
                controller: pageController,
                itemCount: 9,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    nroAlbum: index,
                    currentPage: currentpage,
                  );
                },
              ),
            ),
            const Spacer(),
            Button(controller: pageController),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
