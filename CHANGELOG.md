## [0.0.3] - 2026-10-24

- Republished 0.0.2 without generated build files, cutting the download from 14 MB to about 160 KB. No code changes.

## [0.0.2] - 2026-10-24

- Fixed `getMyDynamicFontSize` returning text smaller than the design size on tablets. The font size follows the screen's height/width ratio, so wider screens got smaller text (16 became about 10.6 on an iPad Air 11" with a 390x844 design frame). On screens whose shortest side is at least 600 logical pixels, the font size is now never smaller than the design size times `scale`. Phone output is unchanged.
- Added `SafeScale.tabletShortestSide` (600), the breakpoint used above.
- Added unit tests for phone and tablet font sizes.

## [0.0.1] - 2026-04-19

- Initial release of SafeScale.
- Implemented `SafeScale` class with controlled scaling support.
- Added dynamic layout utilities for width, height, and font sizes.
- Added `getBottomMarginforBigScreens()` for dynamic margin calculations.
