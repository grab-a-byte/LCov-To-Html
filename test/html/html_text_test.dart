import 'package:lcov_report_gen/html/html_text.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('return string as expected', () {
    var text = HtmlText('test');
    var result = text.toString();

    expect(result, 'test');
  });
}
