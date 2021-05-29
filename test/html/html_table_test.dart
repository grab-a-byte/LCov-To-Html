import 'package:lcov_report_gen/html/html_table.dart';
import 'package:lcov_report_gen/html/html_text.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:lcov_report_gen/extensions/string_extensions.dart';

void main() {
  test('Generates empty table when given empty inputs', () {
    var table = HtmlTable([], []);
    var result = table.toString();
    var expectedResult = '''
      <table>
        <tr>
        </tr>
      </table>
    '''
        .splitTrimAndJoin();

    expect(result, equalsIgnoringWhitespace(expectedResult));
  });

  test('Generates full table when given non-empty inputs', () {
    var table = HtmlTable([
      HtmlText('test'),
      HtmlText('test')
    ], [
      [HtmlText('test'), HtmlText('test')],
      [HtmlText('test'), HtmlText('test')]
    ]);
    var result = table.toString();
    var expectedResult = '''
      <table>
        <tr>
          <th>test</th>
          <th>test</th>
        </tr>
        <tr>
          <td>test</td>
          <td>test</td>
        </tr>
        <tr>
          <td>test</td>
          <td>test</td>
        </tr>
      </table>
    '''
        .splitTrimAndJoin();

    expect(result, equalsIgnoringWhitespace(expectedResult));
  });
}
