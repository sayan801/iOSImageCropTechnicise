//
//  PECropViewController.m
//  PhotoCropEditor
//
//  Created on 2013/05/19.
//

#import "PECropViewController.h"
#import "PECropView.h"
#import "AppDelegate.h"

@interface PECropViewController () <UIActionSheetDelegate>

@property (nonatomic) PECropView *cropView;
@property (nonatomic) UIActionSheet *actionSheet;

- (void)commonInit;

@end

@implementation PECropViewController
{
    UIButton*menuOutlet;
    
}
@synthesize rotationEnabled = _rotationEnabled;

+ (NSBundle *)bundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"PEPhotoCropEditor" withExtension:@"bundle"];
        bundle = [[NSBundle alloc] initWithURL:bundleURL];
    });
    
    return bundle;
}

static inline NSString *PELocalizedString(NSString *key, NSString *comment)
{
    return [[PECropViewController bundle] localizedStringForKey:key value:nil table:@"Localizable"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.rotationEnabled = YES;
}

#pragma mark -

- (void)loadView
{
    
    UIView *contentView = [[UIView alloc] init];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.backgroundColor = [UIColor whiteColor];
    self.view = contentView;
    
    self.cropView = [[PECropView alloc] initWithFrame:contentView.bounds];
    self.cropView.backgroundColor = [UIColor whiteColor];

    [contentView addSubview:self.cropView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(done:)];
    
    */
   // DropDoewnedTable=NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1];
    [self.navigationController.navigationBar setHidden:YES];
    
   //to add navigation title
    self.navigationItem.title=@"Crop Image";
    
    //to change navigation button tittle color
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
   // self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"white_back_iconxhdpi.png"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    

   

    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    ////// For shadow view below navigation bar ///////////////
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    self.navigationController.navigationBar.layer.cornerRadius = 8;
    self.navigationController.navigationBar.layer.shadowRadius = 5;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.9;
   // [self.navigationController.navigationBar bringSubviewToFront:self.navigationController.navigationBar];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel addTarget:self
                   action:@selector(cancel:)
         forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"cancel" forState:UIControlStateNormal];
    [cancel setBackgroundColor:[UIColor blackColor]];
    [cancel setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, 508, 320, 62);
    [self.view addSubview:cancel];
    
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    [done addTarget:self
               action:@selector(done:)
     forControlEvents:UIControlEventTouchUpInside];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    [done setBackgroundColor:[UIColor blackColor]];
    [done setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    done.frame = CGRectMake(0, 448, 320, 60);
    [self.view addSubview:done];


    
    /////////////////////////////////////////////////
    
    //////// Do not showing "Constrain" Button  ////////////
   /*
    /// Constrain button
    if (!self.toolbarItems) {
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
           target:nil
         action:nil];
         
         
        
        UIBarButtonItem *constrainButton = [[UIBarButtonItem alloc] initWithTitle:PELocalizedString(@"Constrain", nil)
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(constrain:)];
        constrainButton.tintColor=[UIColor whiteColor];
        self.toolbarItems = @[flexibleSpace, constrainButton, flexibleSpace];
        self.navigationController.toolbar.barTintColor=[UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1];
      
        ///////////////////////////
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 470, self.view.frame.size.width, 100)];
        
        footer.backgroundColor = [UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1];
        [self.view addSubview:footer];
    }
   // self.navigationController.toolbarHidden = self.toolbarHidden;
    
  */
    
    
    
    // self.navigationController.toolbar.backgroundColor=[UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1] ;
    
    ///
    
//    
//    CGRect cropRect = self.cropView.cropRect;
//    CGSize size = self.cropView.image.size;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    CGFloat ratio;
//    if (width < height) {
//        ratio = width / height;
//        cropRect.size = CGSizeMake(CGRectGetHeight(cropRect) * ratio, CGRectGetHeight(cropRect));
//    } else {
//        ratio = height / width;
//        cropRect.size = CGSizeMake(CGRectGetWidth(cropRect), CGRectGetWidth(cropRect) * ratio);
//    }
//    self.cropView.cropRect = cropRect;
    
    ////
    
   // self.cropView.frame=cropRect;
    
    self.cropView.image = self.image;
    
    self.cropView.rotationGestureRecognizer.enabled = _rotationEnabled;
    
}

-(void)done
{
    //NSLog(@"done");
}


-(void)cancel
{
    //NSLog(@"cancel");
}


//////

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.cropAspectRatio != 0) {
        self.cropAspectRatio = self.cropAspectRatio;
    }
    if (!CGRectEqualToRect(self.cropRect, CGRectZero)) {
        self.cropRect = self.cropRect;
    }
    if (!CGRectEqualToRect(self.imageCropRect, CGRectZero)) {
        self.imageCropRect = self.imageCropRect;
    }
    
    self.keepingCropAspectRatio = self.keepingCropAspectRatio;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark -

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.cropView.image = image;
}

- (void)setKeepingCropAspectRatio:(BOOL)keepingCropAspectRatio
{
    _keepingCropAspectRatio = keepingCropAspectRatio;
    self.cropView.keepingCropAspectRatio = self.keepingCropAspectRatio;
}

- (void)setCropAspectRatio:(CGFloat)cropAspectRatio
{
    _cropAspectRatio = cropAspectRatio;
    self.cropView.cropAspectRatio = self.cropAspectRatio;
}

- (void)setCropRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    _imageCropRect = CGRectZero;
    
    CGRect cropViewCropRect = self.cropView.cropRect;
    cropViewCropRect.origin.x += cropRect.origin.x;
    cropViewCropRect.origin.y += cropRect.origin.y;
    
    CGSize size = CGSizeMake(fminf(CGRectGetMaxX(cropViewCropRect) - CGRectGetMinX(cropViewCropRect), CGRectGetWidth(cropRect)),
                             fminf(CGRectGetMaxY(cropViewCropRect) - CGRectGetMinY(cropViewCropRect), CGRectGetHeight(cropRect)));
    cropViewCropRect.size = size;
    self.cropView.cropRect = cropViewCropRect;
    
    
    
    //NSLog(@"setCropRect");
    
//    CGFloat ratio = 3.0f / 4.0f;
//    cropRect = self.cropView.cropRect;
//    CGFloat width = CGRectGetWidth(cropRect);
//    cropRect.size = CGSizeMake(width, width * ratio);
//    self.cropView.cropRect = cropRect;

    
    
    
}

- (void)setImageCropRect:(CGRect)imageCropRect
{
     ////NSLog(@"setCropRect");
    
   if([imageCrop isEqualToString: @"ChartFinanceUploadInsuCard"])
   {
    
    /*
    _imageCropRect = imageCropRect;
   // _cropRect = CGRectZero;

    
    CGFloat ratio = 3.0f / 5.0f;
    _cropRect = self.cropView.cropRect;
    CGFloat width = CGRectGetWidth(_cropRect);
    _cropRect.size = CGSizeMake(width, width * ratio);
    //_cropRect = _cropRect;
    self.cropView.cropRect = _cropRect;
    self.cropView.imageCropRect = _cropRect;
     */
       
       //_imageCropRect = imageCropRect;
      // _cropRect = CGRectMake(20, 100, 280, 200);
       _cropRect = CGRectMake(0, 100, 320, 220);
       _imageCropRect = CGRectMake(0, 0, 280, 200);
       //    CGFloat ratio = 3.0f / 6.0f;
       //    CGRect cropRect = self.cropView.cropRect;
       //    CGFloat width = CGRectGetWidth(cropRect);
       //    cropRect.size = CGSizeMake(width, width * ratio);
       //    self.cropView.cropRect = cropRect;
       self.cropView.imageCropRect = _imageCropRect;

   }
   else
   {
       self.cropView.cropAspectRatio = 1.0f;
       _imageCropRect = imageCropRect;
      // _imageCropRect=CGRectMake(0, 100, 20, 20);
       _cropRect = CGRectZero;
       // _cropRect = CGRectMake(0, 100, 200, 200);
       self.cropView.imageCropRect = imageCropRect;
        
       
       /*
       _cropRect = CGRectMake(0, 100, 200, 200);
       _imageCropRect = CGRectMake(0, 0, 180, 100);
       self.cropView.imageCropRect = _imageCropRect;
*/
       
       
//       _cropRect = CGRectMake(0, 10, 200, 200);
//       // _imageCropRect = CGRectMake(0, 0, 100, 100);
//       self.cropView.imageCropRect = _imageCropRect;
   }

   
    


    
    
}

- (BOOL)isRotationEnabled
{
    return _rotationEnabled;
}

- (void)setRotationEnabled:(BOOL)rotationEnabled
{
    _rotationEnabled = rotationEnabled;
    self.cropView.rotationGestureRecognizer.enabled = _rotationEnabled;
}

- (CGAffineTransform)rotationTransform
{
    return self.cropView.rotation;
}

- (CGRect)zoomedCropRect
{
    return self.cropView.zoomedCropRect;
}

- (void)resetCropRect
{
    [self.cropView resetCropRect];
}

- (void)resetCropRectAnimated:(BOOL)animated
{
    [self.cropView resetCropRectAnimated:animated];
}

#pragma mark -

- (void)cancel:(id)sender
{
    saveImage=nil;
    _image = nil;
    self.cropView.image = nil;
    
    if ([self.delegate respondsToSelector:@selector(cropViewControllerDidCancel:)]) {
        [self.delegate cropViewControllerDidCancel:self];
    }
}

- (void)done:(id)sender
{
    saveImage=@"imageSelected";
    if ([self.delegate respondsToSelector:@selector(cropViewController:didFinishCroppingImage:transform:cropRect:)]) {
        [self.delegate cropViewController:self didFinishCroppingImage:self.cropView.croppedImage transform: self.cropView.rotation cropRect: self.cropView.zoomedCropRect];
    } else if ([self.delegate respondsToSelector:@selector(cropViewController:didFinishCroppingImage:)]) {
        [self.delegate cropViewController:self didFinishCroppingImage:self.cropView.croppedImage];
    }
}

- (void)constrain:(id)sender
{
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:PELocalizedString(@"Cancel", nil)
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:
                        PELocalizedString(@"Original", nil),
                        PELocalizedString(@"Square", nil),
                        PELocalizedString(@"3 x 2", nil),
                        PELocalizedString(@"3 x 5", nil),
                        PELocalizedString(@"4 x 3", nil),
                        PELocalizedString(@"4 x 6", nil),
                        PELocalizedString(@"5 x 7", nil),
                        PELocalizedString(@"8 x 10", nil),
                        PELocalizedString(@"16 x 9", nil), nil];
    [self.actionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        CGRect cropRect = self.cropView.cropRect;
        CGSize size = self.cropView.image.size;
        CGFloat width = size.width;
        CGFloat height = size.height;
        CGFloat ratio;
        if (width < height) {
            ratio = width / height;
            cropRect.size = CGSizeMake(CGRectGetHeight(cropRect) * ratio, CGRectGetHeight(cropRect));
        } else {
            ratio = height / width;
            cropRect.size = CGSizeMake(CGRectGetWidth(cropRect), CGRectGetWidth(cropRect) * ratio);
        }
        self.cropView.cropRect = cropRect;
    }
    
    else if (buttonIndex == 1)
    {
        self.cropView.cropAspectRatio = 1.0f;
    }
    else if (buttonIndex == 2)
    {
        self.cropView.cropAspectRatio = 2.0f / 3.0f;
    }
    else if (buttonIndex == 3)
    {
        self.cropView.cropAspectRatio = 3.0f / 5.0f;
    }
    else if (buttonIndex == 4)
    {
        CGFloat ratio = 3.0f / 4.0f;
        CGRect cropRect = self.cropView.cropRect;
        CGFloat width = CGRectGetWidth(cropRect);
        cropRect.size = CGSizeMake(width, width * ratio);
        self.cropView.cropRect = cropRect;
    }
    else if (buttonIndex == 5)
    {
        self.cropView.cropAspectRatio = 4.0f / 6.0f;
    }
    else if (buttonIndex == 6)
    {
        self.cropView.cropAspectRatio = 5.0f / 7.0f;
    }
    else if (buttonIndex == 7)
    {
        self.cropView.cropAspectRatio = 8.0f / 10.0f;
    }
    else if (buttonIndex == 8)
    {
        CGFloat ratio = 9.0f / 16.0f;
        CGRect cropRect = self.cropView.cropRect;
        CGFloat width = CGRectGetWidth(cropRect);
        cropRect.size = CGSizeMake(width, width * ratio);
        self.cropView.cropRect = cropRect;
    }
}





@end
