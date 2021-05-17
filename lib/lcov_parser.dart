import 'dart:convert';

import 'package:equatable/equatable.dart';

class LCovCallCount extends Equatable {
  final int lineNumber;
  final int timesCalled;
  LCovCallCount(this.lineNumber, this.timesCalled);

  @override
  List<Object> get props => [lineNumber, timesCalled];
}

class LCovLine {
  final String file;
  final List<LCovCallCount> calls;
  final int totalExecuted;
  final int totalLines;

  LCovLine(this.file, this.calls, this.totalExecuted, this.totalLines);
}

class LCovParser {
  List<LCovLine> parseMultiple(String fullInput) {
    var test = fullInput
        .trim()
        .split('end_of_record')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .map(parseSingle)
        .toList();

    return test;
  }

  LCovLine parseSingle(String singleInput) {
    var lines = LineSplitter().convert(singleInput);
    var fileName = lines[0].substring(3);
    return LCovLine(fileName, getCallCounts(lines),
        _getExecutedlLinesNumber(lines), _getTotalLinesNumber(lines));
  }

  List<LCovCallCount> getCallCounts(List<String> lines) => lines
      .where((element) => element.startsWith('DA:'))
      .map((e) => e.substring(3))
      .map((e) => e.split(','))
      .map((e) => LCovCallCount(int.parse(e[0]), int.parse(e[1])))
      .toList();

  int _getTotalLinesNumber(List<String> lines) =>
      _getSingleLineAsNumber(lines, 3, 'LF');

  int _getExecutedlLinesNumber(List<String> lines) =>
      _getSingleLineAsNumber(lines, 3, 'LH');

  int _getSingleLineAsNumber(
      List<String> lines, int substringStart, String startsWith) {
    var number = lines
        .where((element) => element.startsWith(startsWith))
        .toList()
        .first
        .substring(substringStart);
    return int.parse(number);
  }
}
