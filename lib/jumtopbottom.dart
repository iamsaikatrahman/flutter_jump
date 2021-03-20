import 'package:flutter/material.dart';
import 'package:flutter_jump/utils.dart';

class JumpTopBottom extends StatefulWidget {
  @override
  _JumpTopBottomState createState() => _JumpTopBottomState();
}

class _JumpTopBottomState extends State<JumpTopBottom> {
  final controller = ScrollController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;
      if (isTop) {
        Utils.showSnackBar(context, text: 'Reached Start');
      } else {
        Utils.showSnackBar(context, text: 'Reached End');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Scroll To Top & Bottom"),
        centerTitle: true,
      ),
      body: buildList(),
      bottomNavigationBar: buildBottomBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: scrollUp,
      ));

  Widget buildList() => ListView.builder(
        controller: controller,
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(
          title: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          title: Text('Scroll To Top', style: style),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          title: Text('Scroll To Bottom', style: style),
        ),
      ],
      onTap: (int index) {
        final isSwitchingTab = this.index != index;
        setState(() => this.index = index);

        if (isSwitchingTab) return;
        final isScrollingTop = index == 0;
        if (isScrollingTop) {
          scrollUp();
        } else {
          scrollDown();
        }
      },
    );
  }

  void scrollUp() {
    final double start = 0;
    // controller.jumpTo(start);
    controller.animateTo(start,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  void scrollDown() {
    final double end = controller.position.maxScrollExtent;
    // controller.jumpTo(end);
    controller.animateTo(end,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
