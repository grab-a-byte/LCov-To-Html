import 'package:lcov_report_gen/html/html_element.dart';

class HtmlDocument extends HtmlElement {
  HtmlElement body;

  HtmlDocument({this.body});

  @override
  String toString() {
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
  ${body?.toString() ?? ""}
</body>
</html>
    ''';
  }
}
