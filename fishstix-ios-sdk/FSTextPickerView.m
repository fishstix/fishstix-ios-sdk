//
//  FSTextPickerView.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 11/20/12.
//
//

#import "FSTextPickerView.h"

@interface FSTextPickerView() <UIPickerViewDataSource>
- (void) initialize;
@end

@implementation FSTextPickerView

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
    self.dataSource = self;
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

- (UIView*) viewForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UILabel *lbl = [[UILabel alloc] init];
    [lbl setText:[self.values objectAtIndex:row]];
    [lbl sizeToFit];
    
    return lbl;
}

@end
