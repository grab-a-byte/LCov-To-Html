import 'package:lcov_report_gen/html/html_link.dart';
import 'package:lcov_report_gen/html/html_text.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('generates html corectly', () {
    var link = HtmlLink(HtmlText('test'), 'test.com');
    var result = link.toString();

    expect(result, '<a href=test.com>test</a>');
  });
}
