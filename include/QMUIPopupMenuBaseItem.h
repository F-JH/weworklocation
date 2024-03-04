#import <UIKit/UIView.h>

#import "include/QMUIPopupMenuItemProtocol.h"

@class NSString, QMUIPopupMenuView;

@interface QMUIPopupMenuBaseItem : UIView <QMUIPopupMenuItemProtocol>
{
    NSString *_title;
    double _height;
    id _handler;
    QMUIPopupMenuView *_menuView;
}

@property(nonatomic) __weak QMUIPopupMenuView *menuView; // @synthesize menuView=_menuView;
@property(copy, nonatomic) id handler; // @synthesize handler=_handler;
@property(nonatomic) double height; // @synthesize height=_height;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void)updateAppearance;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end