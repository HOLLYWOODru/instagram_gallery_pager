//
//  STGalleryWireframe.h
//  Sales Tool
//

#import <Foundation/Foundation.h>
#import "PLTypes.h"

@class STGalleryPresenter;


@interface STGalleryWireframe:NSObject
{
    
}

@property (nonatomic,weak) STGalleryPresenter *presenter;

-(void)presentGalleryInView:(UIView *)view;
-(void)hideGallery:(BOOL)animated;

@end
