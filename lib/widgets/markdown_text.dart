import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class MarkdownText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const MarkdownText(this.text,
      {this.style, this.textAlign = TextAlign.left, this.maxLines, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String editedText = text.replaceAll("\"", "”");
    editedText = editedText.replaceAll("'", "’");

    return StyledText(
      text: editedText,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      tags: {
        'bold':
            StyledTextTag(style: style?.copyWith(fontWeight: FontWeight.bold)),
        'b': StyledTextTag(style: style?.copyWith(fontWeight: FontWeight.bold)),
        "italic":
            StyledTextTag(style: style?.copyWith(fontStyle: FontStyle.italic)),
        "i": StyledTextTag(style: style?.copyWith(fontStyle: FontStyle.italic)),
      },
    );
  }
}
