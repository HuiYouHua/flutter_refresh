import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeState createState() {
    return _HomeState();
  }

}

class _HomeState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refresh Demo"),
      ),
      body: RefreshWidget(),
    );
  }
}




class RefreshWidget extends StatefulWidget {

  @override
  _RefreshState createState() {
    return _RefreshState();
  }

}

class _RefreshState extends State<RefreshWidget> {

  GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();
  List<String> _dataSource = List<String>();
  int _pageSize = 0;

  void _loadData(int index) {
    for (int i=0; i<15; i++) {
      _dataSource.add((i+15*index).toString());

    }
  }

  // 下拉刷新
  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      print("正在刷新...");
      _pageSize = 0;
      _dataSource.clear();
      setState(() {
        _loadData(_pageSize);
      });
    });
  }

  // 加载更多
  Future<Null> _loadMoreData() {
    return Future.delayed(Duration(seconds: 1), () {
      print("正在加载更多...");

      setState(() {
        _pageSize++;
        _loadData(_pageSize);
      });
    });
  }

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      _refreshKey.currentState.show().then((e) {});
      return true;
    });
  }

  @override
  void initState() {
    showRefreshLoading();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _onRefresh,
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.all(8.0),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (buildContext, index) {
          return items(context, index);
        },
        itemCount: _dataSource.isEmpty ? 0 : _dataSource.length+1,
        separatorBuilder: (buildContext, index) {
          return Divider(
            height: 1,
            color: Colors.lightGreen,
          );
        },
      ),
    );
  }

  Widget items(context, index) {
    if (index == _dataSource.length) {
      return Container(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "正在加载",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.deepPurple
                    ),
                  )
                ],
              ),
            )
        ),
      );
    }
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text.rich(TextSpan(
              children: [
                TextSpan(text: "我是第"),
                TextSpan(
                    text: "${_dataSource[index]}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(text: "个")
              ]
          )),
        )
    );
  }
}

















