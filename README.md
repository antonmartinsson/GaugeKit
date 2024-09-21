# GaugeKit

GaugeKit is a free-to-use, lightweight Swift package which enables easy, effortless creation of a gauge-like view ideal for visualizing a value in a gauge,
not too different from the native gauges used by Apple for some Apple Watch complications.

## Importing GaugeKit

To use GaugeKit in your project, simply add a Swift Package to your project using the URL to this repository, or add it to your Package.swift manifest manually.

```swift

let package = Package(
  ...
  dependencies: [
    .package(url: "https://github.com/antonmartinsson/gaugekit.git", from: "1.3.0")
  ],
  ...
)
```

## Requirements

GaugeKit is built with SwiftUI, and the minimum requirement to use the latest version is that your project (or the views you're creating with it) has a deployment target set to iOS 13 / macOS 11 / watchOS 6 or later. 

To use it in a UIKit project, use a [UIHostingController](https://developer.apple.com/documentation/swiftui/uihostingcontroller).\
To use it in an AppKit project, use a [NSHostingController](https://developer.apple.com/documentation/swiftui/nshostingcontroller) or [NSHostingView](https://developer.apple.com/documentation/swiftui/nshostingview).

## Usage 

To create a basic Gauge is as simple as providing it with a title, an integer value, and the colors that you want the gauge display along itself.  For example:

```swift
GaugeView(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green])
```

![Gauge](https://raw.githubusercontent.com/antonmartinsson/GaugeKit/3.0/.github/images/gauge_light.png#gh-light-mode-only)
![Gauge](https://raw.githubusercontent.com/antonmartinsson/GaugeKit/3.0/.github/images/gauge_dark.png#gh-dark-mode-only)

A basic gauge like this will default to 100 for its max value. You can also explicitely set the max value of the gauge to a custom value. The following initialization will create a gauge that maxes out at 1000 instead of 100.  

```swift
GaugeView(title: "Speed", value: 100, maxValue: 1000, colors: [.red, .orange, .yellow, .green])
```

Additionally, if you're feeling like you don't need any built in text elements, you could create a gauge without a title or value (or any additional info), like this:  

```swift
GaugeView(colors: [.red, .orange, .yellow, .green])
```

## Modifiers

Should you have the need to customize some of the elements in the Gauge, there are some view modifiers to help you do so. 

### Indicator color

To control the color of the gauge indicator, use the modifier below. By default, the indicator is a cutout of the meter, but setting a specific color will instead layer it above the meter.

```swift
.gaugeIndicatorColor(.blue)
```

### Shadow

To add a shadow to the gauge meter (not including the text within the gauge), use the following modifier.

```swift
.gaugeMeterShadow(color: .black.opacity(0.2), radius: 5)
```

---

Finally, as space for additional information is quite limited within the gauge, you can initialize a gauge with some additional information using three different (optional) strings. This information will be revealed to the user with a quick flip animation when a tap on the gauge view is recorded.   

```swift
let strap = "This is a semi-clever reference."
let title = "#BTTF"
let body = "This is how fast you need to go to trigger the flux capacitor."
let additionalInfo = GaugeAdditionalInfo(strap: strap, title: title, body: body)

GaugeView(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green], additionalInfo: additionalInfo)
```

If you leave any of the strings as nil, the Text instance responsible for displaying that string will not be rendered. So if you just want to create a gauge with a short description and no secondary title or body, this is also a valid init:

```swift
let strap = "This is a semi-clever reference."
let additionalInfo = GaugeAdditionalInfo(strap: strap, title: nil, body: nil)

GaugeView(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green], additionalInfo: additionalInfo)
```

You can control the tint of this back view with the following modifier.
```swift
.gaugeBackTint(.yellow)
```

## Roadmap

While I don't have many concrete plans for GaugeKit at the moment, I do plan to fiddle around with it and improve it best I can from time to time. If you have any feature requests or ideas you think I should take into consideration, please feel free to contact me here [on Twitter](https://x.com/ntonmartinsson).

## Apps using GaugeKit

[Cryptoverview](https://apps.apple.com/se/app/cryptoverview/id1578673077?l=en-GB), by [yours truly](https://x.com/ntonmartinsson)!

[MecaTest](https://apps.apple.com/se/app/mecatest/id6447468608?l=en-GB), by Jean-François Denniel.

[Conal](https://apps.apple.com/se/app/conal/id6450399826?l=en-GB), by [@ConalApp](https://twitter.com/conalapp?s=21&t=cNLR7J7k2hUXZAkqBszDEw).

## Using GaugeKit in your project?

Are you using GuageKit in one of your projects? Please message me and tell me about it on [Twitter](https://www.x.com/ntonmartinsson), and I'll add it to the list above!
