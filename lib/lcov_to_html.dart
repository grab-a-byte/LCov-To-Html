import 'package:lcov_report_gen/html/html_document.dart';
import 'package:lcov_report_gen/html/html_element.dart';
import 'package:lcov_report_gen/html/html_text.dart';
import 'package:lcov_report_gen/html/html_table.dart';

import 'lcov_parser.dart';

HtmlElement LCovToHtml(List<LCovLine> lines) {
  var headers = [
    HtmlText('File'),
    HtmlText('Lines Executed'),
    HtmlText('Lines Found'),
    HtmlText('Percentage')
  ];

  var tableLines = lines.map((e) {
    var percentage = e.totalExecuted / e.totalLines;

    return [
      HtmlText(e.file),
      HtmlText(e.totalExecuted.toString()),
      HtmlText(e.totalLines.toString()),
      HtmlText(percentage.toString())
    ];
  }).toList();

  var totalExecutedLines = lines.fold<int>(
      0, (previousValue, element) => previousValue + element.totalExecuted);

  var totalLines = lines.fold<int>(
      0, (previousValue, element) => previousValue + element.totalLines);

  tableLines.add([
    HtmlText('Total line'),
    HtmlText(totalExecutedLines.toString()),
    HtmlText(totalLines.toString()),
    HtmlText((totalExecutedLines / totalLines).toString())
  ]);

  return HtmlDocument(body: HtmlTable(headers, tableLines));
}
