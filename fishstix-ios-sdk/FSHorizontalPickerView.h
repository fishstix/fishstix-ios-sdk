//
//  MHHorizontalPickerView.h
//  MedTracker
//
//  Created by Charles Fisher on 11/27/12.
//
//

#import <UIKit/UIKit.h>

@class MHHorizontalPickerView;

@protocol MHHorizontalPickerViewDelegate <NSObject>
- (UIView *)pickerView:(MHHorizontalPickerView *)pickerView viewForColumn:(NSInteger)column reusingView:(UIView*)view;
- (CGFloat)pickerViewWidthOfColumn:(MHHorizontalPickerView *)pickerView;
- (NSInteger)pickerViewNumberOfColumns:(MHHorizontalPickerView *)pickerView;
- (void) pickerView:(MHHorizontalPickerView *)pickerView didSelectColumn:(NSInteger)column;
@end

@interface MHHorizontalPickerView : UIPickerView

@property (nonatomic, assign) id<MHHorizontalPickerViewDelegate> delegate;

- (void) selectColumn:(int)selectedColumn animated:(BOOL)animated;
- (int) selectedColumn;

@end
