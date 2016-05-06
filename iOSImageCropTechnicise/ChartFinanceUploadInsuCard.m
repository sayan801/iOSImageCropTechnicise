//
//  ChartFinanceUploadInsuCard.m
//  myCuratio
//
//  Created by technicise on 9/6/14.
//  Copyright (c) 2014 technicise. All rights reserved.
//

#import "ChartFinanceUploadInsuCard.h"


@interface ChartFinanceUploadInsuCard ()
@property(strong,nonatomic) UIBarButtonItem *BarbuttonItem;
@end

@implementation ChartFinanceUploadInsuCard
{
   
   // NSString *saveImage;
   // NSManagedObject *ManagedObject_indivoInsurance;
    NSArray *NsArray_indivoInsurance;
    
    
    
}
@synthesize imagePicker;
@synthesize imageField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    saveImage=nil;
    UIButton *HomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [HomeButton addTarget:self
                   action:@selector(photoAlbumOutletClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [HomeButton setTitle:@"Gallery" forState:UIControlStateNormal];
    [HomeButton setBackgroundColor:[UIColor blackColor]];
    [HomeButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    HomeButton.frame = CGRectMake(-1, 453, 322, 60);
    [self.view addSubview:HomeButton];
    
       ////////////////////////////////////////////////////////////////////////
    
    
/*
        
    if ([GlobalChartEdit isEqualToString:@"EditPictureInsurance"])
    {
        id delegate = [UIApplication sharedApplication].delegate;
        
        NSManagedObjectContext *context = [delegate managedObjectContext];
        
        
        NSEntityDescription *entity1 = [NSEntityDescription
                                        entityForName:@"Indivo_insurance" inManagedObjectContext:context];
        
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
        [request1 setEntity:entity1];
        NSError *error1;
        
        NSPredicate *pred1=[NSPredicate predicateWithFormat:@"(fact_ptr_id=%@)",Indivo_Global_Fact_id];
        
        [request1 setPredicate:pred1];
        NSManagedObject *matches1=nil;
        NSArray *objects1=[context executeFetchRequest:request1 error:&error1];
        
        if([objects1 count]!=0)
            
        {
            matches1= [objects1 objectAtIndex:0];
            //[matches setValue:NPI1 forKey:@"provider_npi"];
            //NSError *error;
            [context save:nil];
            
            
            
          //  [_insuranceCard setImage:[UIImage imageWithData:[matches1 valueForKey:@"insurance_image"]]];
            if ([UIImage imageWithData:[matches1 valueForKey:@"insurance_image"]]) {
                [imageField setImage:[UIImage imageWithData:[matches1 valueForKey:@"insurance_image"]]];
            }
            
        }

    }
 */
    
  
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
/*
-(void)viewDidAppear:(BOOL)animated
{
    ////NSLog(@"viewDidAppear");
    
    if(saveImage==nil){
        
        [self.saveOutlet setHidden:YES];
    }
    else if([saveImage isEqual:@"imageSelected"]){
        [self.saveOutlet setHidden:NO];
        
    }

}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)photoAlbumOutletClick:(id)sender {
    
    imageCrop=@"ChartFinanceUploadInsuCard";
  //  saveImage=@"imageSelected";
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - Image Picker Delegate Methods

//  Dismiss the image picker on selection and use the resulting image in our ImageView
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [imagePicker dismissModalViewControllerAnimated:YES];
    [imageField setImage:image];
}

//  On cancel, only dismiss the picker controller
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    //[imagePicker dismissModalViewControllerAnimated:YES];
//}


//  On cancel, only dismiss the picker controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _ChartFinanceUploadInsuCard = [[ChartFinanceUploadInsuCard alloc] initWithNibName:@"ChartFinanceUploadInsuCard" bundle:nil];
    self.window.rootViewController = _ChartFinanceUploadInsuCard;
    [self.window makeKeyAndVisible];
    
    
    
}

// to crop image


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageField.image = croppedImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    self.imageField.image=nil;
    [controller dismissViewControllerAnimated:YES completion:NULL];
}




- (IBAction)openEditor:(id)sender {
    
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.imageField.image;
    
    UIImage *image = self.imageField.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}



- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:self.BarbuttonItem
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
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
        [self.popover presentPopoverFromBarButtonItem:self.BarbuttonItem
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)updateEditButtonEnabled
{
    // self.editButton.enabled = !!self.imageView.image;
}

#pragma mark - UIActionSheetDelegate methods

/*
 Open camera or photo album.
 */

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageField.image = image;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}






///
/*
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
 {
 [imagePicker dismissModalViewControllerAnimated:YES];
 [imageField setImage:image];
 }
 
 //  On cancel, only dismiss the picker controller
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 //[imagePicker dismissModalViewControllerAnimated:YES];
 }
 */

////
/*
 - (IBAction)cameraButtonAction:(id)sender {
 UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
 delegate:self
 cancelButtonTitle:nil
 destructiveButtonTitle:nil
 otherButtonTitles:NSLocalizedString(@"Photo Album", @"cancel"), nil];
 [actionSheet showFromBarButtonItem:self.cameraButton animated:YES];
 
 }
 */
- (IBAction)test:(id)sender {
    [self openPhotoAlbum];
}

- (IBAction)fromcamera:(id)sender {
    [self showCamera];
}




@end
