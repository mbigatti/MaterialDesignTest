# Material Design Test

Inspired by the recent release of the [Material Design](http://www.google.com/design/) language by Google, I put together an experimental implementation of `UITextField` and `UITextView` that mimic (sort of) the Material Design text fields.
 
![image](http://f.cl.ly/items/1F1g2A311R2r3r1y1G2S/MaterialFramework.gif)

`MaterialTextField` and `MaterialTextView` are Swift components, inspectable in Interface Builder. The components are contained in a Cocoa Touch Framework. They was developed with Xcode6 and IOS8 SDK betas.

Fortunately, a significant part of functionality (moving placeholder) was already implemented in Objective-C by the [JVFloatLabeledTextField project](https://github.com/jverdi/JVFloatLabeledTextField), so I only added the bottom line decoration and the support for field validation. `MaterialTextField` and `MaterialTextView` are subclass of `JVFloatLabeledTextField` and `JVFloatLabeledTextView` respectively.

## Features
- moving placeholder
- bottom decoration line
- error state support with icon and label
- colors and line width are configurable in Interface Builder
- text view auto expand height when required (only AutoLayout supported) 

## Limits
- `MaterialTextView` has some scrolling issue.

## Acknowledgments
Material Framework is based on [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField). Auto expanding UITextView functionality is imported from [AUIAutoGrowingTextView](https://github.com/adam-siton/AUIAutoGrowingTextView).

## Contact

- [Web](http://bigatti.it) 
- [Twitter](https://twitter.com/mbigatti)
