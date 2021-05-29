import 'package:lcov_report_gen/infrastructure/file_loader.dart';
import 'package:lcov_report_gen/lcov_line_to_html_generator.dart';
import 'package:lcov_report_gen/lcov_parser.dart';
import 'package:lcov_report_gen/extensions/string_extensions.dart';
import 'package:test/expect.dart';
import 'package:path/path.dart' as path;
import 'package:test/scaffolding.dart';

import 'expected_output.dart';
import 'test_file.dart';
import 'test_lcov_input.dart';

class FakeFileLoader implements FileLoader {
  final String path;
  final String valueToReturn;

  FakeFileLoader(this.path, this.valueToReturn);

  @override
  Future<String> loadFile(String path) =>
      path == this.path ? Future.value(valueToReturn) : Future.error('oops');
}

Future main() async {
  test('generates html as expected', () async {
    var lcovInput = LCovParser().parseSingle(testLcovInput);

    var rootPath = '/test/path';

    var generator = LCovLineToHtmlGenerator(rootPath,
        FakeFileLoader(path.join(rootPath, lcovInput.file), testFile));

    var resultElement = await generator.generate(lcovInput);
    var result = resultElement.toString();

    expect(result.splitTrimAndJoin(), expectedOutput.splitTrimAndJoin());
  });
}
