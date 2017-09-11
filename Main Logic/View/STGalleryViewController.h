//
//  STGalleryViewController.h
//  Sales Tool
//

#import <UIKit/UIKit.h>
#import "STGalleryModuleInterface.h"
#import "STGalleryViewInterface.h"
#import "STPageControl.h"
#import "PLProtocol.h"

@interface STGalleryViewController:UIViewController<STGalleryViewInterface,UIScrollViewDelegate>
{
    IBOutlet UIView *controlView;
    IBOutlet UIView *contentView;
    IBOutlet STPageControl *pageControl;
    
    IBOutlet NSLayoutConstraint *topViewHeightConstraint;
    IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;
}

@property (nonatomic,strong) id<STGalleryModuleInterface> eventHandler;

-(void)animateContentView;

-(IBAction)closeClicked:(id)sender;

@end
