# MBDebugPanel

[![Version](http://cocoapod-badges.herokuapp.com/v/MBDebugPanel/badge.png)](http://cocoadocs.org/docsets/MBDebugPanel)
[![Platform](http://cocoapod-badges.herokuapp.com/p/MBDebugPanel/badge.png)](http://cocoadocs.org/docsets/MBDebugPanel)

![](http://i.imgur.com/ZejsjMEl.png)

`MBDebugPanel` is a development helper to let you easily add 'behind the scenes' features to your app. It is intended for use during development & debugging.

It offers a *simple way* to define helper tools, and present them in a Table View above the root window.


## Usage

```objc

// Define a component.
MBDebugPanelSimpleButtonComponent *switchComponent
= [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Trigger Some Call"
                                               buttonTitle:@"Do it!"
                                           onButtonPressed:^{
    // Your code here...
    // Skip to a view controller, make an API request... run any code you like.
        
    // (Optionally) dismiss the panel immediately.
    [MBDebugPanel hide];
}];

...

// Present the panel above the root view.
[MBDebugPanel show];

```

## Components

###Included components

`MBDebugPanel` ships with two `MBDebugPanelComponent` implementations to get you going:
* `MBDebugPanelSimpleSwitchComponent` -- renders as a UISwitch and associated description label
* `MBDebugPanelSimpleButtonComponent` -- renders as a UIButton and associated description label 

###Making your own components
You can also define your own componets by implementing the `MBDebugPanelComponent` protocol. It has 2 required methods:

```objc

// The MBDebugPanel know the size of the table cell that will represent this component in a UITableView.
-(CGFloat)cellHeight;

// Components are responsible for returning their representation as a UITableView.
-(UITableViewCell*)cellForDisplayInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;


```


## Demo App

To run the example project; clone the repo and open `MBDebugPanel.xcworkspace`. Select and run the Demo app's scheme.

## Installation

MBDebugPanel is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "MBDebugPanel"

## Author

Matthew Holden, matthew.holden@mindbodyonline.com

## License

MBDebugPanel is available under the MIT license. See the LICENSE file for more info.
