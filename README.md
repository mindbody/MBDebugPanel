# MBDebugPanel

[![Version](http://cocoapod-badges.herokuapp.com/v/MBDebugPanel/badge.png)](http://cocoadocs.org/docsets/MBDebugPanel)
[![Platform](http://cocoapod-badges.herokuapp.com/p/MBDebugPanel/badge.png)](http://cocoadocs.org/docsets/MBDebugPanel)

`MBDebugPanel` is a development helper to let you easily add 'behind the scenes' shortcuts to your app. It is intended for use during development & debugging.

It offers a *simple way* to define helper tools, and present them in a Table View above the root window:

![](http://i.imgur.com/ZejsjMEl.png)

## Basic Usage

```objc

// Define a component.
MBDebugPanelSimpleButtonComponent *buttonComponent
= [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Trigger Some Call"
                                               buttonTitle:@"Do it!"
                                           onButtonPressed:^{
    /* 
      --- Your code goes here ---
      You can skip to a ViewController, trigger some API request,
       run some NSLog's ... anything you'd like to trigger.
    */
        
    // (Optionally) dismiss the panel immediately and return to your app.
    [MBDebugPanel hide];
}];

[MBDebugPanel addComponent:buttonComponent];

...

// Present the panel above the root view.
[MBDebugPanel show];

```

## Included Components

`MBDebugPanel` ships with two `MBDebugPanelComponent` implementations to handle common scenarios:

<br/>
`MBDebugPanelSimpleSwitchComponent` -- renders a UISwitch and description label

![Imgur](http://i.imgur.com/KVJcmUp.png)

<br/>
`MBDebugPanelSimpleButtonComponent` -- renders a UIButton and description label 

![Imgur](http://i.imgur.com/oMVucUG.png)

##Make your own components
You can easily define your own components by implementing the `MBDebugPanelComponent` protocol.

"Components" are objects that represent a row in the Debug Panel.  Components need only conform to the `MBDebugPanelComponent` protocol and implement two methods:

```objc
@protocol MBDebugPanelComponent <NSObject>
@required

// The height this component will require in a UITableView when
// represented as a UITableViewCell
-(CGFloat)cellHeight;

// A UITableView cell representing the component.
// `indexPath` is passed so you can reuse cells with -[UITableView dequeueReusableCellWithIdentifier:forIndexPath]
-(UITableViewCell*)cellForDisplayInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;
```

##Removing components

Components can easily be removed from the DebugPanel. This is particularly useful if you want certain components only visible in certain contexts of your app.

For instance, if your app has a "Create Account" screen, you might wish to quickly fill in some text fields with fake information.

However, you only want this component visible when your app is on that screen:

```objc
@implementation MySignUpViewController

MBDebugPanelSimpleButtonComponent *makeFakeUserButton_;

-(void)viewWillAppear:(BOOL)animated
{
    makeFakeUserButton_ = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Make Fake User" buttonTitle:@"Create" onButtonPressed:^{
        self.firstName.text = @"Fake";
        self.lastName.text  = @"User";
        self.email.text = @"fake.email@example.com"
        ...
        ...

        [MBDebugPanel hide];
    }];
    [MBDebugPanel addComponent:makeFakeUserButton_];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [MBDebugPanel removeComponent:makeFakeUserButton_];
}

...
```

@end

##Automated Management Usage
Automatic management of view controller specific components (like above) can be enabled and disabled via a series of extension selectors on the UIViewController class.

First, to enable component management:

```objc
@implementation MyAutomatedViewController

-(void)viewDidLoad
{
    self.mb_debugMenuItemsManagementEnabled = YES;
    ...
}
```

Next, decide which one or more component items you'd like managed:

```objc
-(void)viewDidLoad
{
    self.mb_debugMenuItemsManagementEnabled = YES;
	
    MBDebugPanelSimpleButtonComponent *button = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Test Button" buttonTitle:@"Pushh Me" onButtonPressed:^{
		NSLog(@"Pushed!");
    }];
    
    [self mb_addManagedDebugMenuItems:@[button] ];

    ...
}
```

Done! If you'd like to stop having one or more component items managed you can remove it:

```obj
    [self mb_removeManagedDebugMenuItems:@[self.debugButton_] ];
```

Please note that automated management uses swizzling.

## Additional APIs

A detailed description of all available APIs is visible in `MBDebugPanel.h`

A number of common utility selectors can be found in `UIViewController+MBDebugPanel.h` including simplified ways to open the Debug Panel as well as add a gesture recognizer programatically to trigger opening of the Debug Panel.

## Demo App

To run the example project; clone the repo and open `MBDebugPanel.xcworkspace`. Select and run the Demo app's scheme.

## Installation

MBDebugPanel is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

    pod "MBDebugPanel"

## Authors

Matthew Holden, matthew.holden@mindbodyonline.com

## License

MBDebugPanel is available under the MIT license. See the LICENSE file for more info.

