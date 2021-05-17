import 'dart:convert';

extension StringExtensions on String {
  String splitTrimAndJoin() =>
      LineSplitter().convert(this).map((e) => e.trim()).join();
}
