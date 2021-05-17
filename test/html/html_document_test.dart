import 'package:lcov_report_gen/html/html_document.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import './test_html_element.dart';

void main() {
  test('Writes out correctly when a body is passed in', () {
    var doc = HtmlDocument(body: TestHtmlElement());

    var result = doc.toString();

    var expectedResult = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
  test
</body>
</html>
    ''';

    expect(result, expectedResult);
  });

  test('Writes out correctly when a no body is passed in', () {
    var doc = HtmlDocument();

    var result = doc.toString();

    var expectedResult = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

</body>
</html>
    ''';

    expect(result, equalsIgnoringWhitespace(expectedResult));
  });
}
