import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:baas_study/utils/dash_path.dart' as dashPath;

import 'dart:math';

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);

/// 验证码输入框
class VerificationCodeInput extends StatefulWidget {
  final double letterSpace;
  final double textSize;
  final int codeLength;
  final InputBorder inputBorder;
  final Future<bool> Function(String code) onEditComplete;

  VerificationCodeInput({
    Key key,
    this.letterSpace = 20.0,
    this.textSize = 20.0,
    this.codeLength = 4,
    this.inputBorder,
    this.onEditComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerificationCodeInputState();
}

class VerificationCodeInputState extends State<VerificationCodeInput> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLength: widget.codeLength,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
      style: TextStyle(
        fontSize: widget.textSize,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black87
            : Colors.white70,
        letterSpacing: widget.letterSpace,
      ),
      decoration: InputDecoration(
        counter: SizedBox(),
        enabledBorder: widget.inputBorder,
        focusedBorder: widget.inputBorder,
      ),
      onChanged: (value) {
        if (value.length == 6) {
          FocusScope.of(context).requestFocus(FocusNode());
          widget.onEditComplete(value).then((result) {
            if (!result) _controller.clear();
          });
        }
      },
    );
  }
}

abstract class InputBorder extends UnderlineInputBorder {
  final double textSize;
  final double letterSpace;
  final int textLength;
  static double _textTrueWidth;
  final double startOffset;

  void calcTrueTextSize() {
    // 测量单个数字实际长度
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: textSize))
      ..addText("0");
    var p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    _textTrueWidth = p.minIntrinsicWidth;
  }

  double get textTrueWidth => _textTrueWidth;

  InputBorder({
    this.textSize = 0.0,
    this.letterSpace = 0.0,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  })  : startOffset = letterSpace * 0.5,
        super(borderSide: borderSide) {
    calcTrueTextSize();
  }
}

/// 方框
class CustomRectInputBorder extends InputBorder {
  CustomRectInputBorder({
    double textSize = 0.0,
    double letterSpace,
    int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  double get offsetX => textTrueWidth * 0.3;

  double get offsetY => textTrueWidth * 0.3;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double curStartX = rect.left + startOffset - offsetX;
    for (int i = 0; i < textLength; i++) {
      Rect r = Rect.fromLTWH(curStartX, rect.top + offsetY,
          textTrueWidth + offsetX * 2, rect.height - offsetY * 2);
      canvas.drawRect(r, borderSide.toPaint());
      curStartX += (textTrueWidth + letterSpace);
    }
  }
}

/// 心形
class CustomHeartInputBorder extends InputBorder {
  CustomHeartInputBorder({
    double textSize = 0.0,
    double letterSpace,
    int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  double get offsetX => textTrueWidth * 0.3;

  // angleOffset should be range 0 to 90.
  double get angleOffset => 40.0;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double width = rect.height - offsetX;
    double radius = width * 0.25;
    // 1:editable.dart _kCaretGap
    double curStartX = startOffset - radius - offsetX - 1;
    if (curStartX < 0) {
      throw ArgumentError(
          'No enough space to paint border! LetterSpace is too small.');
    }
    double top = rect.center.dy - radius * 2;
    double bottom = rect.center.dy + radius * 2;
    Path path = Path();
    for (int i = 0; i < textLength; i++) {
      path.moveTo(curStartX + radius * 2, top + radius);
      path.arcTo(
          Rect.fromCircle(
              center: Offset(curStartX + radius, top + radius), radius: radius),
          degToRad(180.0 - angleOffset),
          degToRad(180.0 + angleOffset),
          true);
      double sinLength = radius * sin(degToRad(angleOffset));
      double cosLength = radius * cos(degToRad(angleOffset));
      path.moveTo(curStartX + radius - cosLength, top + radius + sinLength);
      path.lineTo(curStartX + radius * 2, bottom);
      path.lineTo(curStartX + radius * 3 + cosLength, top + radius + sinLength);
      path.arcTo(
          Rect.fromCircle(
              center: Offset(curStartX + radius * 3, top + radius),
              radius: radius),
          degToRad(angleOffset),
          degToRad(-180.0 - angleOffset),
          true);
      curStartX += (textTrueWidth + letterSpace);
    }
    canvas.drawPath(path, borderSide.toPaint());
  }
}

/// 下划线
class CustomUnderlineInputBorder extends InputBorder {
  CustomUnderlineInputBorder({
    double textSize = 0.0,
    double letterSpace,
    int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
//    if (borderRadius.bottomLeft != Radius.zero ||
//        borderRadius.bottomRight != Radius.zero)
//      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    Path path = Path();
    path.moveTo(rect.bottomLeft.dx + startOffset, rect.bottomLeft.dy);
    path.lineTo(rect.bottomLeft.dx + (textTrueWidth + letterSpace) * textLength,
        rect.bottomRight.dy);
    path = dashPath.dashPath(path,
        dashArray: dashPath.CircularIntervalList<double>([
          textTrueWidth,
          letterSpace,
        ]));
    canvas.drawPath(path, borderSide.toPaint());
  }
}

/// 图片边框
class CustomImageInputBorder extends InputBorder {
  final ui.Image image;

  CustomImageInputBorder({
    @required this.image,
    double textSize = 0.0,
    double letterSpace,
    int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double curStartX = rect.left;
    for (int i = 0; i < textLength; i++) {
      canvas.drawImage(image, Offset(curStartX, 0.0), Paint());
      curStartX += (textTrueWidth + letterSpace);
    }
  }
}
