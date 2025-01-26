### Peckish Animated Hand Tutorial


<p>
  <a href="https://img.shields.io/badge/License-MIT-green"><img align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
  <a href="https://pub.dev/packages/peckish_animated_hand_tutorial/stargazers"><img align="center" src="https://img.shields.io/github/stars/Milad-Akarie/smooth_page_indicator?style=flat&logo=github&colorB=green&label=stars" alt="stars"></a>
  <a href="https://pub.dev/packages/smooth_page_indicator/versions/1.0.0"><img align="center" src="https://img.shields.io/pub/v/smooth_page_indicator.svg" alt="pub version"></a>

</p>

## Table of Contents

1. [](#)
1. [](#)


```dart
CustomMaterialIndicator(
  onRefresh: onRefresh, 
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

### Parameters 

### Properties of `Peckish Hand Tutorial` : 
| Parameter            | Description                                                                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `child`              | The widget that will be wrapped by the tutorial. It can be any widget that you want to show the tutorial for.                               |
| `items`              | A list of `ShowcaseItem` objects, each representing an item in the tutorial.                                                                 |
| `controller`         | An optional `ShowcaseController` to control the tutorial manually (e.g., to start or stop the tutorial).                                      |
| `animationDuration`  | The duration of the animation. Defaults to 3 seconds.                                                                                       |
| `handAssetPath`      | The asset path to the hand image that will be shown during the tutorial. If not provided, the default hand will be used.                     |
| `handSize`           | The size of the hand. Defaults to 50.                                                                                                        |
| `initialDelay`       | An optional delay before the tutorial starts.                                                                                               |
| `handColor`          | The color of the hand. Defaults to white.                                                                                                   |
| `haveRippleEffect`   | A boolean flag indicating whether a ripple effect will be shown. Defaults to false.                                                          |
| `onAnimationComplete`| A callback function that will be triggered when the animation completes.                                                                     |
| `triggerWhen`        | An optional function that defines when the tutorial should be triggered.                                                                    |
| `toolTip`            | The tooltip configuration to display in the tutorial. Defaults to an empty tooltip.                                                          |
| `tooltipBuilder`     | An optional custom builder for the tooltip, which takes a string as an argument and returns a widget.                                         |

### Showcase Item
| Parameter            | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `key`                | A unique key used to identify each showcase item in the tutorial.           |
| `tooltip`            | An optional `ToolTip` object to display additional information about the showcase item. |
| `trigger`            | A boolean that indicates whether the item should trigger the tutorial.      |
| `handAlignment`      | The alignment for the hand when pointing to the showcase item.              |
| `onAnimationComplete`| A callback function that is triggered when the animation for this showcase item is complete. |

### ToolTip TextStyle
| Parameter            | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `fontColor`          | The color of the text inside the tooltip. Defaults to black.                |
| `fontSize`           | The font size of the text inside the tooltip. Defaults to 14.0.             |
| `padding`            | The padding inside the tooltip around the text. Defaults to `EdgeInsets.all(8.0)`. |

### ToolTip Style
| Parameter            | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `backgroundColor`    | The background color of the tooltip.                                         |
| `alignment`          | The alignment of the tooltip relative to its target.                         |
| `padding`            | The padding inside the tooltip.                                              |
| `enableBorder`       | A boolean that enables or disables the border around the tooltip.            |

### ToolTip 
| Parameter           | Description                                                       |
|---------------------|-------------------------------------------------------------------|
| `toolTipMessage`    | A message displayed within the tooltip.                           |
| `toolTipType`       | Defines the type of tooltip (e.g., `bubble`, `simple`).           |
| `onTooltipTap`      | A function that is triggered when the tooltip is tapped.          |
| `toolTipStyle`      | Defines the style (e.g., background color, padding) of the tooltip. |
| `toolTipAlignment`  | Defines the alignment of the tooltip relative to its target.     |
| `toolTipTextStyle`  | Defines the text style (e.g., font size, color) for the tooltip message. |

### ToolTip Touch Type
| Touch Type         | Description                                                      | Preview                                                                 |
|---------------------|------------------------------------------------------------------|-------------------------------------------------------------------------|
| `Touch`             | Represents the ripple effect triggered by touch interaction.     | ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demoworm.gif?raw=true) |

### ToolTip Type
| ToolTip Type   | Preview                                                    |
|-------------|-------------------------------------------------------------------|
| `bubble`    |  ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/worm.gif?raw=true)                  |
| `simple`    |   ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/worm.gif?raw=true)           |



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