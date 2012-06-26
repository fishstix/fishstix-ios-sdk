//
//  FSAppDelegate.h
//  fishstix-ios-sdk
//
//  Created by Charles Fisher on 6/26/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
