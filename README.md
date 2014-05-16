MBAutoGrowingTextView
=====================

An auto-layout based light-weight UITextView subclass which automatically grows and shrinks based on the size of user input and can be constrained by maximal and minimal height - all without a single line of code.

Made primarely for use in Interface builder and only works with Auto layout.

## Quick background
Auto layout is a great way to design your interfaces in a modern iOS application. Certain functionality, however, sometimes can't be achived out-of-the-box. One such example is auto-growing/shrinking UITextView. The problem of this view is that is by default a scrollable view, which means that it's intristic size would not change based on the content. On way around it would be to simply make it unscrollable, however this prevents user to scroll up and down when such element reaches it's maximal height. Thus, MBAutoGrowingTextView was created to work around this problem.

## Functionality
* Made for iOS 7, fully leveraging Interface builder and Auto layout.
* UITextView's height will automatically grow or shrink based on amount of text entered by user
* Maximal and minimal height of the UITextView can be definde from the interface builder
* When maximal height is reached, UITextView content becomes scrollable
* **Not a single line of code required** for complete functionality

![Animated demo](https://raw.githubusercontent.com/MatejBalantic/MBDocs/master/MBAutoGrowingTextView/animated.gif)


## Installation
Installation should be done via Cocoa Pods. 

Install CocoaPods if you didn't yet:
```bash
sudo gem install cocoapods
pod setup
```

Change to the directory of your Xcode project, and Create and Edit your ``Podfile`` and add following line
```
pod 'MBAutoGrowingTextView', '~> 0.1.0'
```

```bash
pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)



## Usage
Usage is extremly simple and intuitive if you know your way around Auto Layout. This class leverages Auto-Layout constraints, by changing "height" constraint when needed. It will detect any "height smaller than" or "height greater than" constraints and make sure they are considered when making calculations.

1. **Add UITextView to your interface file** (storyboard or xib) and resize it to desired size.
![Step 1](https://raw.githubusercontent.com/MatejBalantic/MBDocs/master/MBAutoGrowingTextView/step1.png)



2. Assign custom class to it (click the UITextView, open the right Utilities panel, select third tab (Identity inspector) and write MBAutoGrowingTextView into Custom class field).
![Step 2](https://raw.githubusercontent.com/MatejBalantic/MBDocs/master/MBAutoGrowingTextView/step2.png)



3. **Define the auto-layout constraints** in your interface builder, **as you would normally do**. 
![Step 3](https://raw.githubusercontent.com/MatejBalantic/MBDocs/master/MBAutoGrowingTextView/step3.png)



4. To limit **maximal height**, add the height constant again (as you did above). Select newly added constant and change the Relation field to  "Less than or equal". 
![Step 4](https://raw.githubusercontent.com/MatejBalantic/MBDocs/master/MBAutoGrowingTextView/step4.png)



5. To limit **minimal height**, repeat step 4 and select "Greater than or equal" in relation field
