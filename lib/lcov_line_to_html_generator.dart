import 'dart:convert';

import 'package:lcov_report_gen/html/html_document.dart';
import 'package:lcov_report_gen/html/html_paragraph.dart';
import 'package:lcov_report_gen/html/multi_html_element.dart';
import 'package:lcov_report_gen/infrastructure/file_loader.dart';
import 'package:lcov_report_gen/html/html_element.dart';
import 'package:lcov_report_gen/lcov_parser.dart';

import 'package:path/path.dart' as path;

class LCovLineToHtmlGenerator {
  final String rootPath;
  final FileLoader loader;

  LCovLineToHtmlGenerator(this.rootPath, this.loader);

  Future<HtmlElement> generate(LCovLine lcovInput) async {
    var file = await loader.loadFile(path.join(rootPath, lcovInput.file));
    var lines = LineSplitter().convert(file).asMap();
    var lineElements = lines
        .map((key, value) {
          if (lcovInput.calls.map((e) => e.lineNumber).contains(key + 1)) {
            var wasHit = lcovInput.calls
                    .where((e) => e.lineNumber == key + 1)
                    .first
                    .timesCalled >
                0;
            return MapEntry(
                key,
                HtmlParagrpah(value,
                    backgroundColor: wasHit ? 'green' : 'red'));
          } else {
            return MapEntry(key, HtmlParagrpah(value));
          }
        })
        .values
        .where((element) => element != null)
        .toList();
    var htmlBody = MultiHtmlElement(lineElements);
    return HtmlDocument(body: htmlBody);
  }
}
