import 'package:lcov_report_gen/html/html_element.dart';
import 'package:lcov_report_gen/extensions/string_extensions.dart';

class HtmlTable extends HtmlElement {
  List<HtmlElement> header;
  List<List<HtmlElement>> rows;

  HtmlTable(this.header, this.rows);

  @override
  String toString() {
    var headers = _buildHeaders();
    var rows = _buildRows();
    return '''
<table>
  <tr>
    $headers
  </tr>
  $rows
</table>
      '''
        .splitTrimAndJoin();
  }

  String _buildHeaders() =>
      '${header.map((e) => '<th>${e.toString()}</th>').toList().join()}';

  String _buildRows() {
    return rows
        .map((e) {
          var tableDatas =
              e.map((e) => '<td>${e.toString()}</td>').toList().join();

          return '<tr>$tableDatas</tr>';
        })
        .toList()
        .join();
  }
}
