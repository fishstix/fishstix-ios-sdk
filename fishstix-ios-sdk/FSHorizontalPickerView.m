//
//  MHHorizontalPickerView.m
//  MedTracker
//
//  Created by Charles Fisher on 11/27/12.
//
//

#import "MHHorizontalPickerView.h"

#import <objc/runtime.h>
#import <objc/message.h>

// Creating UIView setFrame method that can be swizzled
@interface MHHelperPickerView : UIView
@end
@implementation MHHelperPickerView
- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
@end

@interface MHNoMoveView : UIView
@end
@implementation MHNoMoveView
- (void) setFrame:(CGRect)frame
{
    // Nope
}
@end

@interface MHHorizontalPickerView () <UIPickerViewDelegate>
@property (nonatomic, assign) CGFloat oldHeight;
@property (nonatomic, assign) BOOL layingSubviews;
@property (nonatomic, assign) id<MHHorizontalPickerViewDelegate> horizontalDelegate;
- (void) mhhorizontalpickerviewinitialize;
@end

@implementation MHHorizontalPickerView
@synthesize horizontalDelegate = _horizontalDelegate;
@dynamic delegate;

#pragma mark -
#pragma mark SWIZZLE

static Method origSetFrameMethod = nil;

__attribute__((constructor))
static void do_the_swizzles() {
    origSetFrameMethod = class_getInstanceMethod([MHHorizontalPickerView class], @selector(setFrame:));
    method_exchangeImplementations(origSetFrameMethod,
                                   class_getInstanceMethod([MHHelperPickerView class], @selector(setFrame:)));
}

#pragma mark -
#pragma mark PROPERTIES

- (void) setDelegate:(id<MHHorizontalPickerViewDelegate>)delegate
{
    self.horizontalDelegate = delegate;    
}

- (id<MHHorizontalPickerViewDelegate>) delegate
{
    return self.horizontalDelegate;
}

#pragma mark -
#pragma mark HIDE SUBVIEWS

#define kHidingSubViewTag 45465752

- (void) layoutSubviews
{
    self.layingSubviews = YES;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, height, width)];
    [super layoutSubviews];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height)];
    
    // Hide non-tableview subviews
    for (UIView *subview in self.subviews) {
        if (![[subview class] isSubclassOfClass:[UITableView class]] && subview.tag == kHidingSubViewTag) {
            [subview setHidden:YES];
        } else if ([[subview class] isSubclassOfClass:[UITableView class]] && subview.tag == kHidingSubViewTag) {
        }
    }
    
    self.layingSubviews = NO;
}

- (void) addSubview:(UIView *)view
{
    if (self.layingSubviews) {
        [view setTag:kHidingSubViewTag];
        if([[view class] isSubclassOfClass:[UITableView class]]) {
            CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI_2);
            [view setTransform:rotate];
            [view setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }
    }
    [super addSubview:view];    
}

#pragma mark -
#pragma mark Init

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self mhhorizontalpickerviewinitialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setFrame:frame];
        [self mhhorizontalpickerviewinitialize];
    }
    return self;
}

-(void) mhhorizontalpickerviewinitialize
{
    self.showsSelectionIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    self.showsSelectionIndicator = NO;
    
    // Delegate
    [super setDelegate:self];    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[UIView class]] && object != self) {
        UIView *view = (UIView*) object;
        if (view.frame.origin.x != 0 || view.frame.origin.y != 0) {
            [view setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        }
    }
}

#pragma mark -
#pragma mark HELPER TRANSLATION

- (void) selectColumn:(int)selectedColumn animated:(BOOL)animated
{
    [self selectRow:selectedColumn inComponent:0 animated:animated];
}

#pragma mark -
#pragma mark DELEGATE TRANSLATION

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    BOOL addObserver = view == nil;
    
    if ([self.horizontalDelegate respondsToSelector:@selector(pickerView:viewForColumn:reusingView:)]) {
        view = [self.horizontalDelegate pickerView:self viewForColumn:row reusingView:view];
    } else {
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,self.frame.size.height)];
    
        NSString *text = @"BLAH";
        labelView.font = [UIFont boldSystemFontOfSize:30.0f];
        labelView.text = [NSLocalizedString(text, nil) uppercaseString];
        labelView.textAlignment = UITextAlignmentCenter;
        labelView.backgroundColor = [UIColor clearColor];

        view = labelView;
    }
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI_2);
	[view setTransform:rotate];

    if (addObserver) {
        [view addObserver:self forKeyPath:@"frame" options:NSKeyValueChangeReplacement context:NULL];
    }
    
    return view;
}

// Actuall ends up being the Width
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if ([self.horizontalDelegate respondsToSelector:@selector(pickerViewWidthOfColumn:)]) {
        return [self.horizontalDelegate pickerViewWidthOfColumn:self];
    }
    return 100;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.horizontalDelegate respondsToSelector:@selector(pickerViewNumberOfColumns:)]) {
        return [self.horizontalDelegate pickerViewNumberOfColumns:self];
    }
	return 100;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.horizontalDelegate respondsToSelector:@selector(pickerView:didSelectColumn:)]) {
        [self.horizontalDelegate pickerView:self didSelectColumn:row];
    }
}

#pragma mark -
#pragma mark PUBLIC

- (int) selectedColumn
{
    return [self selectedRowInComponent:0];
}

@end
