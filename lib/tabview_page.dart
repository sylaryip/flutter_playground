import 'package:flutter/material.dart';

class TabViewPage extends StatefulWidget {
  const TabViewPage({super.key});

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TabViewPage')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentIndex = currentIndex + 1;
          if (currentIndex == 3) currentIndex = 0;

          _tabController?.animateTo(currentIndex);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(height: 100, color: Colors.yellow),
            Expanded(
              child: Scaffold(
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(color: Colors.red),
                    Container(color: Colors.green),
                    Container(color: Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
