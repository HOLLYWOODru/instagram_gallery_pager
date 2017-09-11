//
//  STGalleryItemPresenter.h
//  Sales Tool
//

#import <Foundation/Foundation.h>
#import "STGalleryItemModuleInterface.h"
#import "STGalleryItemInteractorIO.h"
#import "STGalleryItemViewInterface.h"

@protocol STGalleryItemPresenterDelegate<NSObject>

-(void)userTappedOnItemBackground;

@end

@interface STGalleryItemPresenter:NSObject<STGalleryItemModuleInterface,STGalleryItemInteractorOutput>
{

}

@property (nonatomic,strong) id<STGalleryItemInteractorInput> interactor;
@property (nonatomic,weak) UIViewController<STGalleryItemViewInterface> *userInterface;
@property (nonatomic,weak) id<STGalleryItemPresenterDelegate> delegate;

@end
