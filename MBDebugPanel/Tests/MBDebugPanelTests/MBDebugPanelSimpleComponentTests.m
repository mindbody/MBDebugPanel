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
//  MBDebugPanelSimpleButtonComponentTests.m
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import <XCTest/XCTest.h>
#import "MBDebugPanel.h"
#import "MBDebugPanel_Private.h"
#import "MBDebugPanelSimpleButtonComponent.h"
#import "MBDebugPanelSimpleComponent_Protected.h"

#pragma mark 'expose private methods to enable testing'
@interface MBDebugPanelSimpleComponent()
-(UITableViewCell*)dummyCellInstance_;
@end


@interface MBDebugPanelSimpleComponentTests : XCTestCase
@end

@implementation MBDebugPanelSimpleComponentTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
    [MBDebugPanel removeAllComponents];
    [MBDebugPanel hide];
}

- (void)testRegistersForCellReuse
{
    // Add a few 'simple button' components,
    // which is one of the bundled MBDebugPanelSimpleComponent subclasses
    for (int i = 0; i < 5; i++) {
        id c = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"a"
                                                            buttonTitle:@"b"
                                                        onButtonPressed:nil];
        [MBDebugPanel addComponent:c];
    }

    UITableView *tableView = MBDebugPanel.sharedPanel_.tableView;
    // Force table to load (even though it isn't even presented on-screen right now)
    [tableView reloadData];

    // Get all the cell instances in the table
    NSMutableSet *cellInstances = [NSMutableSet setWithArray:[tableView visibleCells]];
    int cellsBeforeReloading = [cellInstances count];
    int cellsAfterReloading;

    // Reload the table
    [tableView reloadData];

    // Meld all cell instances into the table into the original NSSet
    [cellInstances addObjectsFromArray:[tableView visibleCells]];
    cellsAfterReloading = [cellInstances count];

    // Object count should remain the same (cells should be reused)
    XCTAssertEqualWithAccuracy(cellsAfterReloading, cellsBeforeReloading, 1, @"No more than 1 extra cell instance should have been created.  (Had %d before scrolling, and %d after scrolling)", cellsBeforeReloading, cellsAfterReloading);

}

-(void)testThrowsErrorsWhenAbstractMethodsNotOverridden
{
    // Obj-C doesn't actually support abstract classes, so
    // we can 'initialize' an instance of our Abstract class here manually.
    MBDebugPanelSimpleComponent *instance = [MBDebugPanelSimpleComponent new];
    XCTAssertThrows([instance bindToReusableCell:nil], @"Expecting an error");
    XCTAssertThrows([instance cellClassName], @"Expecting an error");
}

-(void)testShouldCacheDummyCellsThatAreCreatedForAGivenSubclass
{
    // 'Dummmy cells' are created to gauge the default 'cell height' after
    // an instnace is loaded from the nib.
    MBDebugPanelSimpleButtonComponent *btn
    = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:nil
                                                   buttonTitle:nil
                                               onButtonPressed:nil];

    UITableViewCell *dummyCell1 = [btn dummyCellInstance_];
    UITableViewCell *dummyCell2 = [btn dummyCellInstance_];

    XCTAssert(dummyCell1 == dummyCell2, @"Should return same cell instance");
}

@end
