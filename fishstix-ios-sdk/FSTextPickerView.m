//
//  FSTextPickerView.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/20/12.
//
//

#import "FSTextPickerView.h"

@interface FSTextPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign) id<UIPickerViewDelegate> privateDelegate;
- (void) initialize;
@end

@implementation FSTextPickerView

#pragma mark -
#pragma mark DELEGATION

- (void) setDelegate:(id<UIPickerViewDelegate>)delegate
{
    self.privateDelegate = delegate;
}

- (id<UIPickerViewDelegate>) delegate
{
    return self.privateDelegate;
}

#pragma mark -
#pragma mark INIT

- (id) init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    self.values = [NSArray array];
    
    self.dataSource = self;
    [super setDelegate:self];
    
    [self addObserver:self forKeyPath:@"values" options:NSKeyValueChangeReplacement context:NULL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self reloadAllComponents];
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (int) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.values count];
}

- (int) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.values objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.privateDelegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.privateDelegate pickerView:pickerView didSelectRow:row inComponent:component];
    }
}

@end
