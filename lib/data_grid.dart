import 'dart:html';
import 'dart:json';
import 'dart:async';
import 'dart:collection';
import 'dart:math';

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

  String get widthStyle {
    if (width is int) return '${width}px';
    return '100%';
  }

  String get heightStyle {
    if (height is int) return '${height}px';
    return '100%';
  }

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

  /**
   * Resizes <col> and header columns to proper sizes.
   */
  _resizeColumns() {
    var headerTable   = _root.query('.mango-data-grid-header-table');
    var dataTable     = _root.query('.mango-data-grid-data-table');
    var headers       = _root.queryAll('.mango-data-grid-header');
    var firstRowCells = _root.queryAll('.mango-data-grid-row > td');
    var cols          = _root.queryAll('.mango-data-grid-col');

    if (firstRowCells.length == 0) return;

    var totalWidth = 1;

    // TODO: What if there are no rows?
    if (firstRowCells.length == 0) return;

    // Reset <col> and header widths.
    cols.forEach((col) => col.style.width = '1px');
    headers.forEach((header) => header.style.width = '1px');
    headerTable.style.width = 'auto';
    dataTable.style.width = 'auto';

    // Make sure that header columns are always as wide as cols, and the other way around as well.
    for (var i = 0, length = headers.length; i < length; i++) {
      var header = headers[i];
      var cell = firstRowCells[i];

      var headerWidth = header.offsetWidth;
      var cellWidth = cell.offsetWidth;

      if (headerWidth > cellWidth) {
        header.style.width = '${headerWidth}px';
        cols[i].style.width = '${headerWidth}px';
        totalWidth += headerWidth;
      } else if (headerWidth < cellWidth) {
        header.style.width = '${cellWidth}px';
        cols[i].style.width = '${cellWidth}px';
        totalWidth += cellWidth;
      }
    }

    // The actual width of the data grid itself (not the contents).
    var actualWidth = _root.query('.mango-data-grid').offsetWidth;

    // If the actual data grid is wider than the contents, then resize the columns so that they fit the data grid width.
    if (actualWidth > totalWidth) {
      var emptySpace = actualWidth - totalWidth;

      // For now, we don't support "weights", so share the space among all columns equally.
      var amountPerCell = (emptySpace / headers.length).ceil().toInt();

      for (var i = 0, length = headers.length; i < length; i++) {
        var amount = amountPerCell;
        if (amount > emptySpace) {
          amount = emptySpace;
        }

        var width = headers[i].offsetWidth + amount;

        headers[i].style.width = '${width}px';
        cols[i].style.width = '${width}px';

        totalWidth += amount;
        emptySpace -= amount;
      }
    }

    headerTable.style.width = '${totalWidth}px';
    dataTable.style.width = '${totalWidth}px';
  }

  sortBy(String id) {
    // See if the column is already sorted.
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