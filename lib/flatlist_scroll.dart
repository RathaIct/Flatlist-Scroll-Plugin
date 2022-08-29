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
  final Widget? errorWidget;
  final String errorMessage;
  final bool reverse;
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
    this.errorWidget,
    this.errorMessage = "Error!",
    this.reverse = false,
  }) : super(key: key);

  @override
  State<FlatlistScroll> createState() => _FlatlistScrollState();
}

class _FlatlistScrollState extends State<FlatlistScroll> {
  int page = 1;
  bool loaded = false;
  bool stopLoaded = false;
  String error = "";
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    page = 1;
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
      page = 1;
      loaded = false;
      stopLoaded = false;
      widget.data.clear();
    }
    if (widget.onLoadMore != null) {
      loaded = false;
      final list = await widget.onLoadMore!(page);
      loaded = true;
      if (list != null) {
        page++;
        stopLoaded = false;
        error = "";
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
        setState(() {
          stopLoaded = true;
          error = widget.errorMessage;
        });
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
        reverse: widget.reverse,
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
                ),
          if (error.isNotEmpty)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: loadData,
                child: widget.errorWidget ??
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          Text(
                            "RETRY",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
