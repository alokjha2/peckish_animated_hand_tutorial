### Peckish Animated Hand Tutorial


<p>
  <a href="https://img.shields.io/badge/License-MIT-green"><img align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
  <a href="https://pub.dev/packages/peckish_animated_hand_tutorial/stargazers"><img align="center" src="https://img.shields.io/github/stars/Milad-Akarie/smooth_page_indicator?style=flat&logo=github&colorB=green&label=stars" alt="stars"></a>
  <a href="https://pub.dev/packages/smooth_page_indicator/versions/1.0.0"><img align="center" src="https://img.shields.io/pub/v/smooth_page_indicator.svg" alt="pub version"></a>

</p>


```dart
CustomMaterialIndicator(
  onRefresh: onRefresh, // Your refresh logic
  backgroundColor: Colors.white,
  indicatorBuilder: (context, controller) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CircularProgressIndicator(
        color: Colors.redAccent,
        value: controller.state.isLoading ? null : math.min(controller.value, 1.0),
      ),
    );
  },
  child: child,
)
```
| Name                                | Type                                         | Required/Optional            | Default Behaviour       Description                                                                    |
|-------------------------------------|----------------------------------------------|------------------------------|------------------------------|--------------------------------------------------------------------------------|
| `child`                             | `Widget`                                     | Required                     |                              | The widget that will be wrapped by the tutorial. It can be any widget that you want to show the tutorial for. |
| `items`                             | `List<ShowcaseItem>`                         | Required                     |                              | A list of `ShowcaseItem` objects, each representing an item in the tutorial.    |
| `controller`                        | `ShowcaseController?`                        | Optional                     | `null`                       | An optional `ShowcaseController` to control the tutorial manually.             |
| `animationDuration`                 | `Duration`                                   | Optional                     | `const Duration(seconds: 3)` | The duration of the animation.                                                 |
| `handAssetPath`                     | `String?`                                    | Optional                     | `null`                       | The asset path to the hand image that will be shown during the tutorial.       |
| `handSize`                          | `double?`                                    | Optional                     | `50`                         | The size of the hand.                                                          |
| `initialDelay`                      | `Duration?`                                  | Optional                     | `null`                       | An optional delay before the tutorial starts.                                  |
| `handColor`                         | `Color?`                                     | Optional                     | `Colors.white`               | The color of the hand.                                                         |
| `haveRippleEffect`                  | `bool?`                                      | Optional                     | `false`                      | A boolean flag indicating whether a ripple effect will be shown.              |
| `onAnimationComplete`               | `Function?`                                  | Optional                     | `null`                       | A callback function that will be triggered when the animation completes.       |
| `triggerWhen`                       | `Function?`                                  | Optional                     | `null`                       | An optional function that defines when the tutorial should be triggered.       |
| `toolTip`                           | `ToolTip`                                    | Optional                     | `ToolTip()`                  | The tooltip configuration to display in the tutorial.                          |
| `tooltipBuilder`                    | `Widget Function(String)?`                   | Optional                     | `null`                       | An optional custom builder for the tooltip, which takes a string and returns a widget. |

## Additional information

TODO: Reach out to peckish human in case of any query regarding package or improvement. Email id - peckishhuman@gmail.com

## Main Contributors

<table>
  <tr>
     <td align="center"><a href="https://github.com/alokjha2"><img src="https://avatars.githubusercontent.com/u/88707242?s=100" width="100px;" alt=""/><br /><sub><b>Peckish Human</b></sub></a></td>
  </tr>
</table>


## License

```text
MIT License

Copyright (c) 2021 Simform Solutions

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```