import 'package:lcov_report_gen/html/html_element.dart';

class HtmlLink extends HtmlElement {
  final HtmlElement inner;
  final String link;

  HtmlLink(this.inner, this.link);

  @override
  String toString() {
    return '<a href=$link>${inner.toString()}</a>';
  }
}
