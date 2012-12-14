//
//  FSCamera.m
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 12/13/12.
//
//

#import "FSCamera.h"

@interface FSCamera() <UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, copy) ImageBlock imageBlock;
@end

@implementation FSCamera

#pragma mark -
#pragma mark SINGLETON

static FSCamera *instance = NULL;

+ (FSCamera*) sharedCamera
{
    @synchronized(self)
    {
        if (instance == NULL) {
            instance = [[FSCamera alloc] init];
        }
    }
    
    return instance;
}

- (void) takePicture:(ImageBlock)block
{
    self.imageBlock = block;
    
    UIActionSheet *cameraSheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        cameraSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Nevermind" destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Take A Photo", @""), @"From Photo Album", nil];
    } else {
        cameraSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Nevermind" destructiveButtonTitle:nil otherButtonTitles:@"From Photo Album", nil];
        
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [cameraSheet showInView:window];
}

#pragma mark -
#pragma mark ACTION SHEET

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] initWithCompletionBlock:^(UIImagePickerController *pickerController, NSDictionary *info){
        
        UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.profileImageView animated:YES];
//        [hud setMode:MBProgressHUDModeIndeterminate];
//        //[hud setLabelText:NSLocalizedString(@"updating", nil)];
//        [hud setUserInteractionEnabled:NO];
//        [hud show:YES];
        
        // 2) Get a concurrent queue form the system
        dispatch_queue_t concurrentQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // 3) Resize image in background
        dispatch_async(concurrentQueue, ^{
            if (pickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {
//                UIImageWriteToSavedPhotosAlbum (fullImage, nil, nil,nil);
            }
            
//            UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(180, 180)];
//            NSData* thumbImageData = UIImagePNGRepresentation(thumbImage);
//            NSData* fullImageData = UIImagePNGRepresentation(fullImage);
            
//            if ([NSKeyedArchiver archiveRootObject:fullImageData toFile:[self fullImagePath]]) {
//                DLog(@"fullImage saved");
//            }
//            if ([NSKeyedArchiver archiveRootObject:thumbImageData toFile:[self thumbImagePath]]) {
//                DLog(@"thumbImage saved");
//            }
            
            //Save thumb to parse
//            PFFile *thumbFile = [PFFile fileWithName:THUMBNAIL_FILE data:thumbImageData];
//            [thumbFile save];
//            [[PFUser currentUser] setObject:thumbFile forKey:USER_PHOTO_THUMBNAIL];
//            [[PFUser currentUser] RTsaveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//                // 4) Present image in main thread
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self displayProfilePhoto];
//                    [hud hide:YES];
//                });
//            }];
            self.imageBlock(fullImage);
        });
        
    } cancelBlock:^(UIImagePickerController *pickerController) {
        self.imageBlock(nil);
    }];
    //pickerController.delegate = self;
    BOOL pickerInitialized = NO;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if (buttonIndex == 0) {
            pickerInitialized = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex == 1) {
            pickerInitialized = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    } else {
        if (buttonIndex == 0) {
            pickerInitialized = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    if (pickerInitialized) {
        [[UIWindow topMostController] presentViewController:pickerController animated:YES completion:^(void) {}];
    } else {
        self.imageBlock(nil);
    }
}


@end
