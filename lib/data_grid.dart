import 'dart:html';
import 'dart:json';
import 'dart:async';
import 'dart:collection';

import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;

class ColumnSort {
  String id;
  bool descending = false;

  ColumnSort(this.id);
}

class MangoDataGrid extends WebComponent {
  List columns;
  List rows;

  int width;
  int height;

  List<ColumnSort> columnSorts = [];

  inserted() {
    Timer.run(doLayout);

    var headerTable = _root.query('.mango-data-grid-header-table');
    var scroller = _root.query('.mango-data-grid-data-scroller');
    scroller.onScroll.listen((_) {
      headerTable.style.left = '-${scroller.scrollLeft}px';
    });
  }

  doLayout() {
    _resizeColumns();
  }

  _resizeColumns() {
    var headers = _root.queryAll('.mango-data-grid-header');
    var firstRowCells = _root.queryAll('.mango-data-grid-row > td');
    var cols = _root.queryAll('.mango-data-grid-col');

    if (firstRowCells.length == 0) return;

    var totalWidth = 0;

    // Reset <col> widths.
    cols.forEach((col) => col.style.width = 'auto');

    // Make sure that header columns are always as wide as cols, and the other way around as well.
    for (var i = 0, length = headers.length; i < length; i++) {
      var header = headers[i];
      var cell = firstRowCells[i];

      if (header.clientWidth > cell.clientWidth) {
        cols[i].style.width = '${header.offsetWidth}px';
        totalWidth += header.offsetWidth;
      } else {
        header.style.width = '${cell.offsetWidth}px';
        totalWidth += cell.offsetWidth;
      }
    }

    _root.query('.mango-data-grid-header-table').style.width = '${totalWidth}px';
    _root.query('.mango-data-grid-data-table').style.width = '${totalWidth}px';
  }

  sortBy(String id) {
    // See if the colum is already sorted.
    ColumnSort sort = columnSorts.firstMatching((c) => c.id == id, orElse: () => null);

    if (sort == null) {
      sort = new ColumnSort(id);

      columnSorts.add(sort);
    } else {
      sort.descending = !sort.descending;

      if (sort.descending == false) columnSorts.remove(sort); // Pressing a header thrice, removes the sort for the header.
    }

    _sort();
  }

  _sort() {
    int compareFields(a, b) {
      if (a == null || b == null) return 0;

      // Numbers and dates can be compared with < and > operators.
      if ((a is num && b is num) || (a is DateTime && b is DateTime)) {
        if (a < b) return -1;
        else if (a == b) return 0;
        else return 1;
      }

      // Strings can be compared with .compareTo().
      if (a is String && b is String) return a.compareTo(b);

      // Booleans are straight-forward.
      if (a is bool && b is bool) {
        if (a == false && b == true) return -1;
        else if (a == true && b == false) return 1;
        else return 0;
      }

      // Generic.
      if (a < b) return -1;
      else if (a > b) return 1;
      else return 0;
    }

    columnSorts.reversed.forEach((ColumnSort sort) {
      rows.sort((left, right) {
        var result = compareFields(left[sort.id], right[sort.id]);

        if (sort.descending) return result * -1;

        return result;
      });
    });

    watchers.dispatch();

    doLayout();
  }

  bool isColumnSorted(String id) => columnSorts.firstMatching((c) => c.id == id, orElse: () => null) != null;

  bool isColumnAscendingSorted(String id) => !columnSorts.firstMatching((c) => c.id == id).descending;
}