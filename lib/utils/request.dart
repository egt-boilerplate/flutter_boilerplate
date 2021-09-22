import 'package:flutter/material.dart';

import '../models/models.dart';

const int defaultPageSize = 10;

typedef ApiRequestFunction<Entity> = Future<Entity> Function(
    {int? pageSize, int? pageNumber});

@optionalTypeArgs
mixin PaginatedRequest<Entity, Resp extends CommonListResponse<Entity>,
    W extends StatefulWidget> on State<W> {
  int _pageNumber = 1;
  bool loading = false;
  int total = 0;
  List<Entity> items = [];
  bool _hasMore = true;

  @protected
  ApiRequestFunction<Resp> get requestFunction;

  Future<bool> fetchData() async {
    try {
      setState(() {
        loading = true;
      });
      var resp = await requestFunction(
          pageSize: defaultPageSize, pageNumber: _pageNumber);
      setState(() {
        total = resp.total;
        items.addAll(resp.items);
        loading = false;
        _hasMore = resp.total > _pageNumber * defaultPageSize;
      });
      return true;
    } catch (e) {
      debugPrint('request error: $e');
      setState(() {
        loading = false;
      });
      return false;
    }
  }

  Future<bool> refresh() async {
    setState(() {
      _pageNumber = 1;
      items = [];
      _hasMore = true;
    });
    return fetchData();
  }

  Future<bool> loadMore() async {
    if (_hasMore) {
      setState(() {
        _pageNumber += 1;
      });
      return fetchData();
    }
    return Future.value(false);
  }
}
