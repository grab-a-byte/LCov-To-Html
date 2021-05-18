import 'package:lcov_report_gen/html/html_element.dart';

class HtmlText extends HtmlElement {
  final String text;

  HtmlText(this.text);

  @override
  String toString() => text;
}
