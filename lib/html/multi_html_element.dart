import 'package:lcov_report_gen/html/html_element.dart';

class MultiHtmlElement extends HtmlElement {
  final List<HtmlElement> elements;

  MultiHtmlElement(this.elements);

  @override
  String toString() => elements.map((e) => e.toString()).join('\n');
}
