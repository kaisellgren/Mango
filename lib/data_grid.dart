import 'dart:html';
import 'dart:json';
import 'dart:async';

import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;

class MangoDataGrid extends WebComponent {
  List columns;
  List rows;

  int width;
  int height;

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
}