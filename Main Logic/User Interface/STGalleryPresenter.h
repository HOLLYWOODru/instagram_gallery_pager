//
//  STGalleryPresenter.h
//  Sales Tool
//

#import <Foundation/Foundation.h>
#import "STGalleryModuleInterface.h"
#import "STGalleryInteractorIO.h"
#import "STGalleryWireframe.h"
#import "STGalleryViewInterface.h"

@interface STGalleryPresenter:NSObject<STGalleryModuleInterface,STGalleryInteractorOutput>
{

}

-(void)clean;

@property (nonatomic,strong) id<STGalleryInteractorInput> interactor;
@property (nonatomic,strong) STGalleryWireframe *wireframe;
@property (nonatomic,weak) UIViewController<STGalleryViewInterface> *userInterface;

@end
