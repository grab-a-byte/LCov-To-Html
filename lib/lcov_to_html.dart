import 'package:lcov_report_gen/file_name_html_element_pair.dart';
import 'package:lcov_report_gen/html/html_document.dart';
import 'package:lcov_report_gen/html/html_element.dart';
import 'package:lcov_report_gen/html/html_link.dart';
import 'package:lcov_report_gen/html/html_text.dart';
import 'package:lcov_report_gen/html/html_table.dart';
import 'package:lcov_report_gen/infrastructure/file_loader.dart';
import 'package:lcov_report_gen/infrastructure/path_manager.dart';
import 'package:lcov_report_gen/lcov_line_to_html_generator.dart';

import 'lcov_parser.dart';

class LCovToHtml {
  final FileLoader _loader;
  final PathManager _pathManager;

  LCovToHtml(this._loader, this._pathManager);

  Future<List<FileNameHtmlElementPair>> getFilesToWrite(
      List<LCovLine> lines) async {
    var lineToHtml = LCovLineToHtmlGenerator(
        _pathManager.getCurrentDirectoryPath(), _loader);
    var pairs = lines
        .map((e) async => FileNameHtmlElementPair(
            '${e.file}.html', await lineToHtml.generate(e)))
        .toList();

    return Future.wait(pairs);
  }

  HtmlElement generateHtml(List<LCovLine> lines) {
    var headers = [
      HtmlText('File'),
      HtmlText('Lines Executed'),
      HtmlText('Lines Found'),
      HtmlText('Percentage'),
      HtmlText('FileShow'),
    ];

    var tableLines = lines.map((e) {
      var percentage = e.totalExecuted / e.totalLines;

      return [
        HtmlText(e.file),
        HtmlText(e.totalExecuted.toString()),
        HtmlText(e.totalLines.toString()),
        HtmlText(percentage.toString()),
        HtmlLink(HtmlText(e.file), './files/${e.file}.html')
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
}
