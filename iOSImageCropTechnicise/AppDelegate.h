//
//  AppDelegate.h
//  iOSImageCropTechnicise
//
//  Created by chandra shekhar sengupta on 06/05/16.
//  Copyright © 2016 chandra shekhar sengupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController1.h"

@class ViewController1;

NSString *saveImage;
NSString *imageCrop;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController1 *ViewController1;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

