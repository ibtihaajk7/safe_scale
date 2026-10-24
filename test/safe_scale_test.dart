import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_scale/safe_scale.dart';

// Design frame used throughout: iPhone 13/14/15 portrait.
const double designHeight = 844;
const double designWidth = 390;

/// Initializes [SafeScale] against a screen of [size] logical pixels.
Future<void> initOn(WidgetTester tester, Size size, {double? scale}) {
  return tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size),
      child: Builder(
        builder: (context) {
          SafeScale().init(context, designHeight, designWidth, scale: scale);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
}

/// Font size from the aspect-ratio formula used by 0.0.1, which phones keep.
double aspectFontSize(Size size, double fontSize, {double scale = 1.0}) {
  final deviceRatio = size.height / size.width;
  const designRatio = designHeight / designWidth;
  return fontSize * deviceRatio / designRatio * scale;
}

void main() {
  group('getMyDynamicFontSize on phones', () {
    const phones = {
      'design frame (390x844)': Size(390, 844),
      'iPhone 15 (393x852)': Size(393, 852),
      'iPhone SE (375x667)': Size(375, 667),
      'iPhone 8 Plus (414x736)': Size(414, 736),
      'Pixel 7 (412x915)': Size(412, 915),
      'iPhone 15 landscape (852x393)': Size(852, 393),
    };

    phones.forEach((name, size) {
      testWidgets('$name keeps the aspect-ratio formula', (tester) async {
        await initOn(tester, size);
        expect(
          SafeScale.getMyDynamicFontSize(16),
          closeTo(aspectFontSize(size, 16), 1e-9),
        );
      });
    });

    testWidgets('design frame returns the design size', (tester) async {
      await initOn(tester, const Size(390, 844));
      expect(SafeScale.getMyDynamicFontSize(16), closeTo(16, 1e-9));
    });

    testWidgets('scale is applied on phones', (tester) async {
      const size = Size(393, 852);
      await initOn(tester, size, scale: 0.9);
      expect(
        SafeScale.getMyDynamicFontSize(16),
        closeTo(aspectFontSize(size, 16, scale: 0.9), 1e-9),
      );
    });
  });

  group('getMyDynamicFontSize on tablets', () {
    const tablets = {
      'iPad Air 11" (820x1180)': Size(820, 1180),
      'iPad Air 11" landscape (1180x820)': Size(1180, 820),
      'iPad mini (744x1133)': Size(744, 1133),
      'iPad Pro 13" (1032x1376)': Size(1032, 1376),
      'Android tablet (800x1280)': Size(800, 1280),
    };

    tablets.forEach((name, size) {
      testWidgets('$name is not smaller than the design size', (tester) async {
        await initOn(tester, size);
        expect(SafeScale.getMyDynamicFontSize(16), closeTo(16, 1e-9));
      });
    });

    testWidgets('scale is applied on top of the design size', (tester) async {
      await initOn(tester, const Size(820, 1180), scale: 1.2);
      expect(SafeScale.getMyDynamicFontSize(16), closeTo(19.2, 1e-9));
    });

    testWidgets('maxlimit still caps the result', (tester) async {
      await initOn(tester, const Size(820, 1180), scale: 1.2);
      expect(SafeScale.getMyDynamicFontSize(16, maxlimit: 18), 18);
    });

    testWidgets('widths and heights still scale by screen size',
        (tester) async {
      await initOn(tester, const Size(820, 1180));
      expect(SafeScale.getMyDynamicWidth(designWidth), closeTo(820, 1e-9));
      expect(SafeScale.getMyDynamicHeight(designHeight), closeTo(1180, 1e-9));
    });
  });
}
