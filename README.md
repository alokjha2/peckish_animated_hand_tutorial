# Peckish Animated Hand Tutorial

<p>
  <a href="https://img.shields.io/badge/License-MIT-green"><img align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
  <a href="https://pub.dev/packages/peckish_animated_hand_tutorial/stargazers"><img align="center" src="https://img.shields.io/pub/v/peckish_animated_hand_tutorial.svg" alt="pub version"></a>
</p>

This package guides users through in-app tutorials by animating a hand that points at widgets, surfaces a themed tooltip, and optionally adds ripple feedback. It ships with a default hand asset but lets you override every aspect of the animation, tooltip, and start/end behavior using `ShowcaseItem`, `ToolTip`, and `ShowcaseController`.

## Table of Contents
1. [Installation](#installation)
1. [Quick start](#quick-start)
1. [Configuration reference](#configuration-reference)
   1. [PeckishHandTutorial widget](#peckishhandtutorial-widget)
   1. [ShowcaseItem](#showcaseitem)
   1. [ToolTip](#tooltip)
   1. [ToolTipStyle and ToolTipTextStyle](#tool-tip-style-and-tool-tip-text-style)
   1. [ToolTipType](#tooltiptype)
1. [Controllers](#controllers)
1. [Customization notes](#customization-notes)
1. [Example](#example)
1. [Assets](#assets)
1. [Development & testing](#development--testing)
1. [Contact & contributions](#contact--contributions)
1. [License](#license)

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  peckish_animated_hand_tutorial: ^1.0.2
  logger: ^1.0.0 # logger is re-exported by the package
```

Run `flutter pub get`. The package requires Flutter SDK `>=1.17.0` and Dart `>=3.3.4`.

### Assets

The widget defaults to the bundled asset at `packages/peckish_animated_hand_tutorial/assets/animated_hand.png`. Provide your own via `handAssetPath` and declare it in your app’s `flutter/assets` list if you want a branded hand animation instead of the built-in image.

## Quick start

```dart
PeckishHandTutorial(
  child: Scaffold(
    appBar: AppBar(title: const Text('Demo')),
    body: Center(
      child: ElevatedButton(
        key: buttonKey,
        onPressed: () {},
        child: const Text('Start tutorial'),
      ),
    ),
  ),
  items: [
    ShowcaseItem(
      key: buttonKey,
      tooltip: const ToolTip(
        toolTipMessage: 'Tap here to begin',
        toolTipType: ToolTipType.bubble,
        toolTipStyle: ToolTipStyle(backgroundColor: Colors.blue),
      ),
    ),
  ],
)
```

Highlights:

- Animated hand follows each `ShowcaseItem` in order and clamps to the screen bounds.
- Default tooltip renderer (`ToolTipWidget`) supports `bubble`, `simple`, and a custom `cloud` shape.
- Ripple effect, hand size/color/asset, and tooltip builder are all configurable.
- You can delay or gate startup, and you always get access to the `ShowcaseController` if you prefer to drive the animation externally.

## Configuration reference

### PeckishHandTutorial widget

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `child` | `Widget` | — | The widget tree that hosts the tutorial. The hand and tooltips are stacked on top of this widget. |
| `items` | `List<ShowcaseItem>` | — | Ordered list of targets for the animated hand. Each item must supply a `GlobalKey`. |
| `controller` | `ShowcaseController?` | `null` | Optional controller to inspect or control the current offset, tooltip state, etc. Without one the widget creates an internal controller. |
| `animationDuration` | `Duration` | `Duration(seconds: 3)` | Duration for each hand animation segment. |
| `handAssetPath` | `String?` | `null` | Asset path to your hand image. Defaults to the packaged asset. |
| `handSize` | `double?` | `50` | Diameter of the rendered hand graphic. |
| `initialDelay` | `Duration?` | `null` | Present in the API but not read anywhere in the implementation yet. |
| `handColor` | `Color?` | `Colors.white` | Color blended on top of the hand asset. |
| `haveRippleEffect` | `bool?` | `false` | When `true`, a ripple expands from the hand during each animation cycle. |
| `loop` | `bool?` | `false` | Not currently consumed; reserved for future loops through `items`. |
| `onAnimationComplete` | `Function?` | `null` | Exists for future callbacks when the entire tutorial finishes but is not invoked yet. |
| `triggerWhen` | `Function(Function startTutorial)?` | `null` | Receives a callback that starts the animation on demand. Needed if `initiallyHide` is `true`. |
| `initialAlignment` | `Alignment?` | `Alignment.bottomRight` | Starting position for the hand before it reaches the first `ShowcaseItem`. |
| `initiallyHide` | `bool?` | `false` | Keeps the hand hidden until `triggerWhen` calls its received starter callback. Asserts that `triggerWhen` is provided when set to `true`. |
| `toolTip` | `ToolTip` | `const ToolTip()` | Defaults for tooltips shown when the hand reaches a target. |
| `tooltipBuilder` | `Widget Function(String tooltip)?` | `null` | Build your own tooltip widget. If not supplied the widget renders `ToolTipWidget`. |

### ShowcaseItem

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `key` | `GlobalKey` | — | Identifies the target render object. The hand positions itself based on this key. |
| `tooltip` | `ToolTip?` | `null` | Tooltip data that overwrites the parent `toolTip` defaults when present. |
| `trigger` | `bool?` | `null` | Exposed by the model but not read in the current animation pipeline. |
| `handAlignment` | `Alignment?` | `null` | Intended to control the hand’s alignment per item; not yet used. |
| `onAnimationComplete` | `Function?` | `null` | Placeholder for future per-item completion callbacks. |

### ToolTip

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `toolTipMessage` | `String?` | `null` | Text shown inside the tooltip bubble. |
| `toolTipType` | `ToolTipType?` | `null` | Controls which tooltip painter is used by `ToolTipWidget`. |
| `onTooltipTap` | `Function?` | `null` | Present for future tap handling but not wired yet. |
| `toolTipStyle` | `ToolTipStyle?` | `null` | Custom style (background color, padding, border flag). Currently only `backgroundColor` is applied by the widget. |
| `toolTipAlignment` | `Alignment?` | `null` | Stored for future alignment-based placement. |
| `toolTipTextStyle` | `ToolTipTextStyle?` | `null` | Allows you to supply font settings, but the default tooltip widget currently uses fixed `TextStyle` values. |

### Tool Tip Style and Tool Tip Text Style

#### ToolTipStyle

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `backgroundColor` | `Color` | `Colors.white` | Background fill of the tooltip. |
| `alignment` | `Alignment` | `Alignment.bottomCenter` | Reserved for future placement logic. |
| `padding` | `EdgeInsets` | `EdgeInsets.all(8.0)` | Reported padding; tooling currently ignores it. |
| `enableBorder` | `bool` | `false` | Intended to toggle borders but not referenced yet. |

#### ToolTipTextStyle

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `fontColor` | `Color` | `Colors.black` | Text color (currently unused). |
| `fontSize` | `double` | `14.0` | Font size (currently unused). |
| `padding` | `EdgeInsets` | `EdgeInsets.all(8.0)` | Declarative padding unit (not applied). |

### ToolTipType

| Value | Description |
| --- | --- |
| `ToolTipType.bubble` | Rounded capsule with shadow and border produced by `_buildBubbleTooltip()`. |
| `ToolTipType.simple` | Simple bubble with border created by `_buildSimpleTooltip()`. |
| `ToolTipType.cloud` | Custom-painted “cloud” shape rendered by `CloudBorderPainter`. |

When you supply `toolTipType`, `ToolTipWidget` selects the corresponding builder. If you opt-in via `tooltipBuilder`, you can render anything instead.

## Controllers

`ShowcaseController` extends `ChangeNotifier` and synchronizes the hand animation with the tooltip display. Access it via the `controller` parameter or use the internal controller exposed through `PeckishHandTutorial`.

| Member | Type | Description |
| --- | --- | --- |
| `items` | `List<ShowcaseItem>` | Current item list. Mutating this list manually requires following `List` semantics; use `setItems` to replace it atomically. |
| `isPlaying` | `bool` | Flag toggled whenever the controller cycles through `_currentIndex` (not currently updated by the widget). |
| `currentOffset` | `Offset` | Current hand position (updated from `_animateToPosition`). |
| `showTooltip` | `bool` | Controls whether the tooltip container is painted. |
| `currentTooltip` | `ToolTip` | Returns the tooltip of the current item or a fallback with message “No tooltip available”. |
| `addItem(ShowcaseItem item)` | — | Appends an item and notifies listeners. |
| `setItems(List<ShowcaseItem> items)` | — | Clears and replaces the entire item list. |
| `updateOffset(Offset offset)` | — | Updates `currentOffset` during animation frames. |
| `setShowTooltip(bool show)` | — | Toggles `showTooltip`. |
| `next()` | — | Advances `_currentIndex` if not at the end. |
| `reset()` | — | Resets `_currentIndex`, hides the tooltip, and sets the offset to `Offset.zero`. |

## Customization notes

- **Custom tooltips**: Provide `tooltipBuilder` to draw your own widget. The default `ToolTipWidget` uses the `ToolTipType` enum to pick between `_buildBubbleTooltip`, `_buildSimpleTooltip`, and `_buildCloudTooltip`, and it paints the `toolTipMessage` text using hard-coded `TextStyle` values.
- **Ripple effect**: Set `haveRippleEffect` to `true` to emit a growing circle behind the hand (`_rippleController` drives size/opacity). The ripple color is derived from `handColor`.
- **Hand appearance**: Override `handAssetPath`, `handSize`, and `handColor` to match your brand. The default image is tinted with `BlendMode.modulate`.
- **Startup control**: Use `initialAlignment` to place the hand before it targets the first item. Pass `initiallyHide: true` along with `triggerWhen` to start the sequence manually. `triggerWhen` receives a `Function` callback you invoke once your UI is ready. The hand clamps the animation to the screen bounds so targets near the edge stay visible.
- **Unimplemented parameters**: `loop`, `initialDelay`, `onAnimationComplete`, `ShowcaseItem.trigger`, `ShowcaseItem.handAlignment`, and `ToolTip`/style alignment/padding hooks are exposed but not consumed in the current implementation; treat them as reserved for future releases.

## Example

See `example/lib/main.dart` for a working demo. The app wires two `ShowcaseItem`s to a button and a menu icon and shows how to:

1. Provide `GlobalKey`s for target widgets.
1. Supply a custom `ToolTip` for each item.
1. Enable ripple feedback and tint the hand green.

Run the demo with:

```bash
cd example
flutter run
```

## Assets

- `assets/animated_hand.png` &rarr; default asset shipped with the package. Refer to it through `handAssetPath` if you copy it into your app.
- If you supply a different asset, remember to register it under your top-level `flutter/assets` block.

## Development & testing

- `flutter test` — verify unit/widgets.
- `flutter analyze` — static analysis powered by `flutter_lints`.

## Contact & contributions

Questions, requests, or PR ideas? Email peckishhuman@gmail.com or open an issue at `https://github.com/alokjha2/peckish_animated_hand_tutorial/issues`.

## License

MIT © Peckish Human
