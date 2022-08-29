import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlatlistScroll extends StatefulWidget {
  List data;
  final ScrollController controller;
  final Widget Function(dynamic) renderItem;
  final Future<void> Function()? onRefresh;
  final Future<List<dynamic>?> Function(int page)? onLoadMore;
  final Function(List<dynamic>?)? updated;
  final int onLoadMoreThreshold;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  FlatlistScroll({
    Key? key,
    required this.controller,
    required this.renderItem,
    required this.data,
    this.onRefresh,
    this.onLoadMore,
    this.onLoadMoreThreshold = 100,
    this.updated,
    this.loadingWidget,
    this.emptyWidget,
  }) : super(key: key);

  @override
  State<FlatlistScroll> createState() => _FlatlistScrollState();
}

class _FlatlistScrollState extends State<FlatlistScroll> {
  int page = 0;
  bool loaded = false;
  bool stopLoaded = false;
  String? error;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    page = 0;
    loaded = false;
    stopLoaded = false;
    super.dispose();
  }

  Future initialize() async {
    await loadData();
    widget.controller.addListener(() async {
      final position = widget.controller.position;
      bool scrollFetch = position.pixels >
          position.maxScrollExtent - widget.onLoadMoreThreshold;
      if (scrollFetch) {
        if (loaded && !stopLoaded) {
          await loadData();
        }
      }
    });
  }

  Future loadData({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 0;
      loaded = false;
      stopLoaded = false;
      widget.data.clear();
    }
    if (widget.onLoadMore != null) {
      loaded = false;
      page++;
      final list = await widget.onLoadMore!(page);
      loaded = true;
      if (list != null) {
        widget.data += list;
        if (list.isEmpty) {
          setState(() {
            stopLoaded = true;
          });
        }
        if (widget.updated != null) {
          widget.updated!(widget.data);
        } else {
          setState(() {});
        }
      } else {
        error = "Error!";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (loaded) await loadData(isRefresh: true);
        if (widget.onRefresh != null) {
          await widget.onRefresh!();
        }
      },
      child: ListView(
        controller: widget.controller,
        children: [
          ...widget.data.map((e) => widget.renderItem(e)).toList(),
          if (!stopLoaded)
            widget.loadingWidget ??
                const SizedBox(
                  height: 50,
                  child: CircularProgressIndicator.adaptive(),
                ),
          if (stopLoaded && widget.data.isEmpty)
            widget.emptyWidget ??
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("No data"),
                )
        ],
      ),
    );
  }
}
