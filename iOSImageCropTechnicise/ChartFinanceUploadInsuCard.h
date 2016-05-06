//
//  ChartFinanceUploadInsuCard.h
//  myCuratio
//
//  Created by technicise on 9/6/14.
//  Copyright (c) 2014 technicise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"
#import "AppDelegate.h"


@interface ChartFinanceUploadInsuCard : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate>


@property (nonatomic) UIPopoverController *popover;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) ChartFinanceUploadInsuCard*ChartFinanceUploadInsuCard;


@property (nonatomic,retain) NSString *user_id;

@property (strong, nonatomic) IBOutlet UIImageView *imageField;

//- (IBAction)back:(id)sender;


- (IBAction)photoAlbumOutletClick:(id)sender;



//- (IBAction)cameraClick:(id)sender;

//- (IBAction)save:(id)sender;


@property (nonatomic,retain) NSString *pass_insurence_unique_id;



@property (strong, nonatomic) IBOutlet UILabel *NavigationBar;


@end
