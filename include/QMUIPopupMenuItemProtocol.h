#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QMUIPopupMenuView;

@protocol QMUIPopupMenuItemProtocol <NSObject>

/// item 里的文字
@property(nonatomic, copy, nullable) NSString *title;

/// item 的高度，默认为 -1，-1 表示高度以 QMUIPopupMenuView.itemHeight 为准。如果设置为 QMUIViewSelfSizingHeight，则表示高度由 -[self sizeThatFits:] 返回的值决定。
@property(nonatomic, assign) CGFloat height;

/// item 被点击时的事件处理接口，QMUIPopupMenuBaseItem 里仅声明，只有 QMUIPopupMenuButtonItem 会自动调用。若继承 QMUIPopupMenuBaseItem 衍生自己的子类，也需要手动调用它。
/// @note 需要在内部自行隐藏 QMUIPopupMenuView。
@property(nonatomic, copy, nullable) void (^handler)(__kindof NSObject<QMUIPopupMenuItemProtocol> *aItem);

/// 当前 item 所在的 QMUIPopupMenuView 的引用，只有在 item 被添加到菜单之后才有值。
@property(nonatomic, weak, nullable) QMUIPopupMenuView *menuView;

/// item 被添加到 menuView 之后（也即 menuView 属性有值了）会被调用，可在这个方法里更新 item 的样式（因为某些样式可能需要从 menuView 那边读取）
- (void)updateAppearance;

@end

NS_ASSUME_NONNULL_END