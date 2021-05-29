import 'package:lcov_report_gen/html/html_element.dart';

class HtmlParagrpah extends HtmlElement {
  final String text;
  String backgroundColor;

  HtmlParagrpah(this.text, {this.backgroundColor});

  @override
  String toString() {
    var styleText = backgroundColor == null
        ? ""
        : ' style="background-color: $backgroundColor;"';
    return '<p$styleText>$text</p>';
  }
}
