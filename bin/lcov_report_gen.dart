import 'dart:io';

import 'package:lcov_report_gen/infrastructure/file_loader.dart';
import 'package:lcov_report_gen/infrastructure/path_manager.dart';
import 'package:path/path.dart' as path;
import 'package:lcov_report_gen/lcov_parser.dart';
import 'package:lcov_report_gen/lcov_to_html.dart';

void main(List<String> arguments) async {
  var pathManager = SystemPathManager();

  var filePath = arguments.first;
  var file = File(filePath);

  var input = await file.readAsString();

  var parsedInput = LCovParser().parseMultiple(input);

  var lcovToHtml = LCovToHtml(SystemFileLoader(), pathManager);

  var output = lcovToHtml.generateHtml(parsedInput);

  var outputFile =
      File(path.join(pathManager.getDownloadsPath(), 'output.html'));

  await outputFile.writeAsString(output.toString());

  var filesToWrites = await lcovToHtml.getFilesToWrite(parsedInput);

  filesToWrites.map((e) async {
    var file =
        File(path.join(pathManager.getDownloadsPath(), '${e.fileName}.html'));
    await file.writeAsString(e.element.toString());
  });
}
