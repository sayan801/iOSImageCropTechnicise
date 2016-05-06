//
//  ViewController1.h
//  iOSImageCropTechnicise
//
//  Created by Souman Paul on 5/6/16.
//  Copyright © 2016 chandra shekhar sengupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"


@interface ViewController1 : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate>




@property (nonatomic) UIPopoverController *popover;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

- (IBAction)UploadFromGallery:(id)sender;


@end
