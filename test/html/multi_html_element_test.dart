import 'package:lcov_report_gen/html/html_text.dart';
import 'package:lcov_report_gen/html/multi_html_element.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Prints all internal elements', () {
    var element = MultiHtmlElement([HtmlText('test'), HtmlText('test2')]);

    var expectedResult = '''
    test
    test2
    ''';

    expect(element.toString(), equalsIgnoringWhitespace(expectedResult));
  });
}
