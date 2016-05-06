//
//  ViewController1.m
//  iOSImageCropTechnicise
//
//  Created by Souman Paul on 5/6/16.
//  Copyright © 2016 chandra shekhar sengupta. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
@property(strong,nonatomic) UIBarButtonItem *BarbuttonItem;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)UploadFromGallery:(id)sender {
    
     [self openPhotoAlbum];
}



- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:_BarbuttonItem
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        //_BarbuttonItem
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}
@end
