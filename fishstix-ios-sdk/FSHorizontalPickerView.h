//
//  FSHorizontalPickerView.h
//  MedTracker
//
//  Created by Charles Fisher on 11/27/12.
//
//

#import <UIKit/UIKit.h>

@class FSHorizontalPickerView;

@protocol FSHorizontalPickerViewDelegate <NSObject>
- (UIView *)pickerView:(FSHorizontalPickerView *)pickerView viewForColumn:(NSInteger)column reusingView:(UIView*)view;
- (CGFloat)pickerViewWidthOfColumn:(FSHorizontalPickerView *)pickerView;
- (NSInteger)pickerViewNumberOfColumns:(FSHorizontalPickerView *)pickerView;
- (void) pickerView:(FSHorizontalPickerView *)pickerView didSelectColumn:(NSInteger)column;
@end

@interface FSHorizontalPickerView : UIPickerView

@property (nonatomic, assign) id<FSHorizontalPickerViewDelegate> delegate;

- (void) selectColumn:(int)selectedColumn animated:(BOOL)animated;
- (int) selectedColumn;

@end
