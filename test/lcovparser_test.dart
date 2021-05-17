import 'package:lcov_report_gen/lcov_parser.dart';
import 'package:test/test.dart';

import './sample_input_single.dart';
import 'sample_input_full.dart';

void main() {
  var parser = LCovParser();
  group('Single line', () {
    test('Reads a file name correctly', () {
      var result = parser.parseSingle(singleInput);
      expect(result.file, 'lib\client\models\hero\hero.dart');
    });

    test('Gets correct call pairings lengths', () {
      var result = parser.parseSingle(singleInput);

      expect(result.calls.length, 21);
    });
    test('Gets correct call pairings values', () {
      var result = parser.parseSingle(singleInput);

      var expectedOutput = [
        LCovCallCount(9, 2),
        LCovCallCount(10, 2),
        LCovCallCount(11, 2),
        LCovCallCount(12, 2),
        LCovCallCount(13, 2),
        LCovCallCount(14, 2),
        LCovCallCount(15, 2),
        LCovCallCount(16, 4),
        LCovCallCount(17, 2),
        LCovCallCount(18, 2),
        LCovCallCount(19, 2),
        LCovCallCount(20, 4),
        LCovCallCount(21, 2),
        LCovCallCount(22, 2),
        LCovCallCount(26, 0),
        LCovCallCount(27, 0),
        LCovCallCount(28, 0),
        LCovCallCount(29, 0),
        LCovCallCount(30, 0),
        LCovCallCount(31, 0),
        LCovCallCount(32, 0),
      ];

      expect(result.calls, expectedOutput);
    });

    test('Gets corect number of lines found', () {
      var result = parser.parseSingle(singleInput);
      expect(result.totalLines, 21);
    });

    test('Gets corect number of lines executed', () {
      var result = parser.parseSingle(singleInput);
      expect(result.totalExecuted, 14);
    });
  });

  group('Multi-line file', () {
    test('Counts correct number of files', () {
      var result = parser.parseMultiple(fullInput);
      expect(result.length, 31);
    });
  });
}
