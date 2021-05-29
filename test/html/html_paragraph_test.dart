import 'package:lcov_report_gen/html/html_paragraph.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('generates html successfully', () {
    var paragraph = HtmlParagrpah('paragraph');
    var result = paragraph.toString();
    expect(result, '<p>paragraph</p>');
  });

  test('background color applies correctly', () {
    var paragraph = HtmlParagrpah('paragraph', backgroundColor: 'red');
    var result = paragraph.toString();
    expect(result, '<p style="background-color: red;">paragraph</p>');
  });
}
