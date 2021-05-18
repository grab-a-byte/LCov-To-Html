import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:lcov_report_gen/lcov_parser.dart';
import 'package:lcov_report_gen/lcov_to_html.dart';

String getHomePath() {
  var envVars = Platform.environment;
  if (Platform.isMacOS) {
    return envVars['HOME'];
  } else if (Platform.isLinux) {
    return envVars['HOME'];
  } else if (Platform.isWindows) {
    return envVars['UserProfile'];
  }
}

String getDownloadsPath() {
  var home = getHomePath();
  return path.join(home, 'Downloads');
}

void main(List<String> arguments) async {
  var filePath = arguments.first;
  var file = File(filePath);

  var input = await file.readAsString();

  var parsedInput = LCovParser().parseMultiple(input);

  var output = LCovToHtml(parsedInput);

  var outputFile = File(path.join(getDownloadsPath(), 'output.html'));

  await outputFile.writeAsString(output.toString());
}
