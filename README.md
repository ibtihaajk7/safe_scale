# SafeScale 🛡️

SafeScale is a production-grade responsive scaling utility for Flutter that prevents "UI bloat" on problematic devices. Designs on specific screen sizes can be converted using functions to become responsive in different screen sizes while maintaining "Safe Rails."

- [Usage](#usage)
  - [Initialize in init](#initialization)
  - [Get values](#get-values)
  - [Use in widgets](#use-in-widgets)
  - [The "Safe" Scaling Recipe](#the-safe-scaling-recipe)
  - [Other Functionalities](#other-functionalities)

## Usage

### Initialization

Initialize `SafeScale().init` in your `main.dart` under the `build` method.

```dart
SafeScale().init(context, height, width, scale: myCalculatedScale);
```

| parameter | description                                                                              |
| --------- | ---------------------------------------------------------------------------------------- |
| context   | BuildContext in init of main.dart                                                        |
| height    | `height` is the height of the frame in design files (e.g., 844)                          |
| width     | `width` is the width of the frame in design files (e.g., 390)                             |
| scale     | (Optional) A manually calculated scale factor to clamp scaling on large or low-DPI screens. Defaults to 1.0. |

### Get values

These functions return responsive values according to screensize in `double`.

```dart
SafeScale.getMyDynamicHeight(heightInDesignFile, maxlimit: maxlimit);
SafeScale.getMyDynamicFontSize(fontSizeInDesignFile, maxlimit: maxlimit);
SafeScale.getMyDynamicWidth(widthInDesignFile, maxlimit: maxlimit);
SafeScale.getBottomMarginforBigScreens();
```

where:
|parameter|description|
|-----------------------------------|--------------------------------------|
|heightInDesignFile |is the height factor according to the device designer in `design` files|
|widthInDesignFile |is the width factor according to the device designer in `design` files|
|maxlimit |is the maximum value that the variable will be limited to|
|fontSizeInDesignFile |is the font factor according to the device designer in `design` files|

### Use in widgets

```dart
Container(
    height: SafeScale.getMyDynamicHeight(200),
    width: SafeScale.getMyDynamicWidth(100),
    color: Colors.amber.shade100,
  );
```

## The "Safe" Scaling Recipe

To prevent "UI bloat" on large budget Androids or non-standard iPhones, we recommend this initialization pattern in your `main.dart`:

```dart
final media = MediaQuery.of(context);
final width = media.size.width;
final dpr = media.devicePixelRatio;

// Detect large physical screens with low density (the 'Bloat' zone)
final isLowDensityLargeScreen = width > 360 && dpr < 3.0;

// Calculate scale with safety clamps
double scale = (width / 390).clamp(
  isLowDensityLargeScreen ? 0.85 : 0.9,
  isLowDensityLargeScreen ? 1.0 : 1.15
);

SafeScale().init(context, 844, 390, scale: scale);
```

### Other Functionalities

| variables        | description                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| horizontalBlock  | If screen width is divided into `100 pixels` after subtracting horizontal safe area it returns `1 pixel` i.e. 1/100th of screen width |
| verticalBlock    | If screen height is divided into `100 pixels` it returns `1 pixel` i.e. 1/100th of screen height.                                     |
| screenHeight     | height of screen using [MediaQuery]                                                                                                   |
| screenWidth      | width of screen using [MediaQuery]                                                                                                    |
| statusBarPadding | get **stausBarPadding** using [MediaQuery]                                                                                            |

```dart
  SafeScale.verticalBlock;
  SafeScale.horizontalBlock;
  SafeScale.screenHeight;
  SafeScale.screenWidth;
  SafeScale.statusBarPadding;
```
