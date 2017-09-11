//
//  STGalleryItemViewController.h
//  Sales Tool
//

#import <UIKit/UIKit.h>
#import "STGalleryItemModuleInterface.h"
#import "STGalleryItemViewInterface.h"

@interface STGalleryItemViewController:UIViewController<STGalleryItemViewInterface>
{
    IBOutlet UIView *containerView;
    IBOutlet UIImageView *imageView;
    
    IBOutlet UIView *loadingView;
    IBOutlet UIImageView *downloadingIcon;
    
    IBOutlet NSLayoutConstraint *containerWidthConstraint;
    IBOutlet NSLayoutConstraint *containerHeightConstraint;
    
    IBOutlet NSLayoutConstraint *borderLeftConstraint;
    IBOutlet NSLayoutConstraint *borderRightConstraint;
    IBOutlet NSLayoutConstraint *borderTopConstraint;
    IBOutlet NSLayoutConstraint *borderBottomConstraint;
}

@property (nonatomic,strong) id<STGalleryItemModuleInterface> eventHandler;

-(IBAction)userTappedOnBackground:(id)sender;

@end
