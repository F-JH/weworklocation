//
// Created by Xiaoandi Fu on 2024/3/1.
//
#import <UIKit/UIKit.h>

@class NSArray, NSIndexPath, NSMutableArray, UIColor, UIFont, UIScrollView;

@interface QMUIPopupMenuView
{
    _Bool _shouldShowItemSeparator;
    _Bool _shouldShowSectionSeparator;
    UIColor *_itemSeparatorColor;
    double _itemSeparatorHeight;
    UIColor *_sectionSeparatorColor;
    double _sectionSeparatorHeight;
    double _sectionSpacing;
    UIFont *_sectionTitleFont;
    UIColor *_sectionTitleColor;
    id _sectionTitleConfigurationHandler;
    UIFont *_itemTitleFont;
    UIColor *_itemTitleColor;
    double _itemHeight;
    id _itemConfigurationHandler;
    id _willHandleButtonItemEventBlock;
    NSArray *_items;
    NSArray *_itemSections;
    NSArray *_sectionTitles;
    UIScrollView *_scrollView;
    NSMutableArray *_itemSeparatorLayers;
    NSMutableArray *_sectionSeparatorLayers;
    NSMutableArray *_sectionTitleLabels;
    struct UIEdgeInsets _itemSeparatorInset;
    struct UIEdgeInsets _sectionSeparatorInset;
    struct UIEdgeInsets _sectionTitlePadding;
    struct UIEdgeInsets _padding;
}

+ (void)setDefaultAppearanceForPopupMenuView;
+ (void)initialize;
+ (id)wwk_styledPopoverMenu2;
+ (id)wwk_styledPopoverMenu;
+ (id)wwk_styledCheckmarkPopoverMenu;
+ (id)wwk_styledTabViewPopoverMenu;
+ (id)wwk_styledSearchCheckboxPopoverMenu;
+ (id)wwk_styledSearchCheckmarkPopoverMenu;
@property(retain, nonatomic) NSMutableArray *sectionTitleLabels; // @synthesize sectionTitleLabels=_sectionTitleLabels;
@property(retain, nonatomic) NSMutableArray *sectionSeparatorLayers; // @synthesize sectionSeparatorLayers=_sectionSeparatorLayers;
@property(retain, nonatomic) NSMutableArray *itemSeparatorLayers; // @synthesize itemSeparatorLayers=_itemSeparatorLayers;
@property(retain, nonatomic) UIScrollView *scrollView; // @synthesize scrollView=_scrollView;
@property(copy, nonatomic) NSArray *sectionTitles; // @synthesize sectionTitles=_sectionTitles;
@property(copy, nonatomic) NSArray *itemSections; // @synthesize itemSections=_itemSections;
@property(copy, nonatomic) NSArray *items; // @synthesize items=_items;
@property(copy, nonatomic) id willHandleButtonItemEventBlock; // @synthesize willHandleButtonItemEventBlock=_willHandleButtonItemEventBlock;
@property(copy, nonatomic) id itemConfigurationHandler; // @synthesize itemConfigurationHandler=_itemConfigurationHandler;
@property(nonatomic) double itemHeight; // @synthesize itemHeight=_itemHeight;
@property(nonatomic) struct UIEdgeInsets padding; // @synthesize padding=_padding;
@property(retain, nonatomic) UIColor *itemTitleColor; // @synthesize itemTitleColor=_itemTitleColor;
@property(retain, nonatomic) UIFont *itemTitleFont; // @synthesize itemTitleFont=_itemTitleFont;
@property(copy, nonatomic) id sectionTitleConfigurationHandler; // @synthesize sectionTitleConfigurationHandler=_sectionTitleConfigurationHandler;
@property(nonatomic) struct UIEdgeInsets sectionTitlePadding; // @synthesize sectionTitlePadding=_sectionTitlePadding;
@property(retain, nonatomic) UIColor *sectionTitleColor; // @synthesize sectionTitleColor=_sectionTitleColor;
@property(retain, nonatomic) UIFont *sectionTitleFont; // @synthesize sectionTitleFont=_sectionTitleFont;
@property(nonatomic) double sectionSpacing; // @synthesize sectionSpacing=_sectionSpacing;
@property(nonatomic) double sectionSeparatorHeight; // @synthesize sectionSeparatorHeight=_sectionSeparatorHeight;
@property(nonatomic) struct UIEdgeInsets sectionSeparatorInset; // @synthesize sectionSeparatorInset=_sectionSeparatorInset;
@property(retain, nonatomic) UIColor *sectionSeparatorColor; // @synthesize sectionSeparatorColor=_sectionSeparatorColor;
@property(nonatomic) _Bool shouldShowSectionSeparator; // @synthesize shouldShowSectionSeparator=_shouldShowSectionSeparator;
@property(nonatomic) double itemSeparatorHeight; // @synthesize itemSeparatorHeight=_itemSeparatorHeight;
@property(nonatomic) struct UIEdgeInsets itemSeparatorInset; // @synthesize itemSeparatorInset=_itemSeparatorInset;
@property(retain, nonatomic) UIColor *itemSeparatorColor; // @synthesize itemSeparatorColor=_itemSeparatorColor;
@property(nonatomic) _Bool shouldShowItemSeparator; // @synthesize shouldShowItemSeparator=_shouldShowItemSeparator;
- (void)layoutSubviews;
- (struct CGSize)sizeThatFitsInContentView:(struct CGSize)arg1;
- (void)didInitialize;
- (void)enumerateItemsWithBlock:(id)arg1;
- (void)configureItems;
- (void)updateAppearanceForPopupMenuView;
- (void)wwk_styledAsPopoverMenu2;
- (void)wwk_styledAsPopoverMenu;
@property(nonatomic) unsigned long long wwk_checkedItemIndex;
@property(retain, nonatomic) NSIndexPath *wwk_checkedItemIndexPath;
- (void)wwk_styledAsCheckmarkPopoverMenu;
- (void)wwk_styledAsTabViewPopoverMenu;
- (void)wwk_styledAsSearchCheckboxPopoverMenu;
- (void)wwk_styledAsSearchCheckmarkPopoverMenu;
- (void)hideWithAnimated:(BOOL)animated;

@end


