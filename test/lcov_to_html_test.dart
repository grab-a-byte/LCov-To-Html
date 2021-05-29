import 'package:lcov_report_gen/infrastructure/file_loader.dart';
import 'package:lcov_report_gen/infrastructure/path_manager.dart';
import 'package:lcov_report_gen/lcov_parser.dart';
import 'package:lcov_report_gen/lcov_to_html.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:lcov_report_gen/extensions/string_extensions.dart';

import './sample_input_single.dart';
import 'asmple_input_single_html.dart';
import 'sample_input_file.dart';

class FakeFileLoader implements FileLoader {
  final String path;
  final String valueToReturn;

  FakeFileLoader(this.path, this.valueToReturn);

  @override
  Future<String> loadFile(String path) =>
      path == this.path ? Future.value(valueToReturn) : Future.error('oops');
}

class FakePathManager implements PathManager {
  @override
  String getCurrentDirectoryPath() => '';

  @override
  String getDownloadsPath() => 'Downloads';
}

void main() {
  test('generates correct html from lines', () {
    var html = singleInputHtml.splitTrimAndJoin();

    var result = LCovToHtml(SystemFileLoader(), SystemPathManager())
        .generateHtml([LCovParser().parseSingle(singleInput)]);
    expect(result.toString().splitTrimAndJoin(), html);
  });

  test('gets files to write generates files', () async {
    var fakeManager = FakePathManager();
    var fakeLoader =
        FakeFileLoader('lib\client\models\hero\hero.dart', sampleInput);

    var lcovToHtml = LCovToHtml(fakeLoader, fakeManager);

    var result = await lcovToHtml
        .getFilesToWrite([LCovParser().parseSingle(singleInput)]);

    expect(result.length, 1);
    expect(result.first.element.toString(), contains('test1'));
    expect(result.first.element.toString(), contains('test30'));
  });
}
