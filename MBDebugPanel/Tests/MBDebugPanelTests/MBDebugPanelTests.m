//Copyright (c) 2014 MINDBODY, Inc. <www.mindbodyonline.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//
//  MBDebugPanelTests.m
//  MBDebugPanelTests
//
//  Created by Matthew Holden on 2/6/14.
//
//

#import <XCTest/XCTest.h>
#import "MBDebugPanel.h"
#import "MBDebugPanel_Private.h"

#import "MBDebugPanelSimpleButtonComponent.h"
#import "MBDebugPanelSimpleSwitchComponent.h"

@interface MBDebugPanelTests : XCTestCase
@end

@implementation MBDebugPanelTests

#pragma mark helpers

static int dummyButtonHandlerInvocations = 0;
static void(^dummyButtonHanlder)(void) = ^{
    dummyButtonHandlerInvocations++;
};

static int dummySwitchHandlerInvocations = 0;
static void(^dummySwitchHanlder)(void) = ^{
    dummySwitchHandlerInvocations++;
};

-(id<MBDebugPanelComponent>)makeButton
{
    return [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"title"
                                                        buttonTitle:@"button"
                                                    onButtonPressed:nil];
}
-(id<MBDebugPanelComponent>)makeSwitch
{
    return [[MBDebugPanelSimpleSwitchComponent alloc] initWithTitle:@"switch"
                                                       initialValue:true
                                                    onSwitchChanged:nil];
}

#pragma mark tests
-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [MBDebugPanel removeAllComponents];
    [super tearDown];
}

-(void)testCanAddAComponent
{
    NSAssert([[[MBDebugPanel sharedPanel_] components] count] == 0, @"tearDown method should have removed all components");

    [MBDebugPanel addComponent:[self makeButton]];
    XCTAssert([MBDebugPanel.sharedPanel_.components count] == 1, @"Should be able to add a component");
}
-(void)testCanRemoveAComponent
{
    NSAssert([[[MBDebugPanel sharedPanel_] components] count] == 0, @"tearDown method should have removed all components");

    id<MBDebugPanelComponent> button;
    id<MBDebugPanelComponent> aSwitch;
    [MBDebugPanel addComponent:(button = [self makeButton])];
    [MBDebugPanel addComponent:(aSwitch = [self makeSwitch])];

    [MBDebugPanel removeComponent:button];
    XCTAssert([MBDebugPanel.sharedPanel_.components count] == 1, @"Should be able to add a component");
    XCTAssert(MBDebugPanel.sharedPanel_.components[0] == aSwitch, @"Switch component should be what's left.");
}

-(void)testOnlyOneSectionSupported /*right now*/
{
    id<UITableViewDataSource, UITableViewDelegate> panel = [MBDebugPanel sharedPanel_];
    XCTAssert([panel numberOfSectionsInTableView:[UITableView new]] == 1, @"Number of sections is hard-coded to 1.");
}

-(void)testTableRowCountIsSameAsComponentCount
{
    const int kCount = 5;
    for (int i = 0; i < kCount; i++)
        [MBDebugPanel addComponent:[self makeButton]];

    id<UITableViewDataSource, UITableViewDelegate> panel = [MBDebugPanel sharedPanel_];
    XCTAssert([panel tableView:[UITableView new] numberOfRowsInSection:0] == kCount, @"Row count should be equal to number of components");
}

-(void)testReloadsTableDataWhenShown
{
    // Make sure we're starting on a clean slate as far
    // as rendered cells are concerned
    [MBDebugPanel.sharedPanel_.tableView reloadData];

    [MBDebugPanel addComponent:[self makeButton]];
    [MBDebugPanel show];
    UITableViewCell *cell1 = [MBDebugPanel.sharedPanel_.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    [MBDebugPanel hide];
    [MBDebugPanel removeAllComponents];

    [MBDebugPanel addComponent:[self makeSwitch]];
    [MBDebugPanel show];
    // We're expecting that -[UITableView reloadData] should have been called during the 'show' method
    UITableViewCell *cell2 = [MBDebugPanel.sharedPanel_.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    NSInteger tableRowCount = [MBDebugPanel.sharedPanel_.tableView numberOfRowsInSection:0];
    XCTAssert(tableRowCount == 1, @"There should only be 1 row displayed in the table, instead saw %ld", (long)tableRowCount);
    XCTAssert(cell1 != cell2, @"The displayed cell should be re-rendered and now of a different type, since it was from a different component.  Renderered cell was instance of %@", NSStringFromClass(cell2.class));
}

@end
