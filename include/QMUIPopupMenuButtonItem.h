@class QMUIButton, UIColor, UIImage, QMUIPopupMenuBaseItem;

@interface QMUIPopupMenuButtonItem : QMUIPopupMenuBaseItem
{
    UIImage *_image;
    QMUIButton *_button;
    UIColor *_highlightedBackgroundColor;
    double _imageMarginRight;
}

+ (id)itemWithImage:(id)arg1 title:(id)arg2 handler:(id)arg3;
+ (void)setDefaultAppearanceForPopupMenuView;
+ (void)initialize;
@property(nonatomic) double imageMarginRight; // @synthesize imageMarginRight=_imageMarginRight;
@property(retain, nonatomic) UIColor *highlightedBackgroundColor; // @synthesize highlightedBackgroundColor=_highlightedBackgroundColor;
@property(readonly, nonatomic) QMUIButton *button; // @synthesize button=_button;
@property(retain, nonatomic) UIImage *image; // @synthesize image=_image;
- (void)updateAppearance;
- (void)handleButtonEvent:(id)arg1;
- (void)updateButtonImageEdgeInsets;
- (void)setTitle:(id)arg1;
- (void)layoutSubviews;
- (struct CGSize)sizeThatFits:(struct CGSize)arg1;
- (id)init;
- (void)updateAppearanceForMenuButtonItem;

@end

