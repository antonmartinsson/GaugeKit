# GaugeKit

GaugeKit is a Swift package which enables easy, effortless creation of a gauge-like view ideal for visualizing a value between 0 and 100 in a gauge,
not too different from the native gauges used by Apple for some Apple Watch complications.

## Importing GaugeKit

To use GaugeKit in your project, simply add a Swift Package to your project using the URL to this repository, or add it to your Package.swift manifest manually.

```swift

let package = Package(
	...
	dependencies: [
		.package(url: "https://github.com/antonmartinsson/gaugekit.git", from: "0.1.0")
	],
	...
)
```

## Usage 

To create a basic Gauge is as simple as providing it with a title, an integer value between 0 and 100, and the colors that you want the gauge display along itself. For example:

```swift
Gauge(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green])
```

Additionally, as space for additional information is quite limited within the gauge, you can initialize a gauge with some additional information using three different (optional) strings. This information will be revealed to the user with a quick flip animation when a tap on the gauge view is recorded.   

```swift
let description = "This is a semi-clever reference."
let secondaryTitle = "#BTTF"
let body = "This is how fast you need to go to trigger the flux capacitor."
let additionalInfo = GaugeAdditionalInfo(secondaryTitle: secondaryTitle, description: description, body: body)

Gauge(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green], additionalInfo: additionalInfo)
```

If you leave any of the strings as nil, the Text instance responsible for displaying that string will not be rendered. So if you just want to create a gauge with a short description and no secondary title, this is also a valid init:

```swift
let description = "This is a description."
let additionalInfo = GaugeAdditionalInfo(secondaryTitle: nil, description: description, body: nil)

Gauge(title: "Speed", value: 88, colors: [.red, .orange, .yellow, .green], additionalInfo: additionalInfo)
```

Finally, if you're feeling like you don't need any built in text elements, you could create a gauge without a title or value (or any additional info), like this:  

```swift
Gauge(colors: [.red, .orange, .yellow, .green])
```

## Requirements

GaugeKit is built with SwiftUI, and thus the minimum requirement to use it is that your project (or the views you're creating with it) has a deployment target set to iOS 13 or later.




