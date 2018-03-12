
#import "MJJMainPopoutView.h"
#import "MJJConstant.h"
#import "NSArray+Extension.h"
#import "UIView+Extension.h"
#import <Masonry.h>
#import "MJJCollectionViewCell.h"
#import "MJJCollectionViewFlowLayout.h"
#import "MJJItemModel.h"

@interface MJJMainPopoutView () <UICollectionViewDelegate,UICollectionViewDataSource,MJJCollectionViewFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger selectedIndex; // 选择了哪个
@property (nonatomic,strong) NSMutableArray *datas;

// 血糖/血压 按钮
@property (nonatomic,strong)UIButton *actionBtn;



@end

static NSString *indentify = @"MJJCollectionViewCell";

@implementation MJJMainPopoutView
{
    NSInteger _selectedIndex;
}

// self是继承于UIView的，给上面的第一个View容器加个动画
- (void)showInSuperView:(UIView *)superView
{
    [superView addSubview:self];
}

// 初始化 设置背景颜色透明点，然后加载子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _selectedIndex = 0;
        self.backgroundColor = RGB(51, 51, 51, 0.5);
        [self addsubviews];
    }
    return self;
}

// 加载子视图
- (void)addsubviews{
    [self addSubview:self.collectionView];
    [self addSubview:self.actionBtn];

}

#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MJJItemModel *model = self.datas[indexPath.item];
    MJJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.heroImageVIew.image = [UIImage imageNamed:model.imageName];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"血糖测量";
        cell.icon.image = [UIImage imageNamed:@"Start_measuring_button_image"];

    }else{
        cell.titleLabel.text = @"血压测量";
        cell.icon.image = [UIImage imageNamed:@"icon_xueya"];

    }
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != self.selectedIndex) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(clickMeasure:)]) {
        [self.delegate clickMeasure:self.selectedIndex];
    }

}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        MJJCollectionViewFlowLayout *flow = [[MJJCollectionViewFlowLayout alloc] init];//MJJCollectionViewFlowLayout
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(self.width / 2,self.width / 2);
        flow.minimumLineSpacing = 10;
        flow.minimumInteritemSpacing = 10;
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.needAlpha = YES;
        flow.delegate = self;
        CGFloat oneX =self.width / 4;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 1) collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    }
    return _collectionView;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 50 , 100, 44)];
        _actionBtn.backgroundColor = [UIColor redColor];
        [_actionBtn setTitle:@"血糖数据 >" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(clickDataBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _actionBtn;
}

- (void)clickDataBtn{

    if ([self.delegate respondsToSelector:@selector(clickActionBtn:)]) {
        [self.delegate clickActionBtn:self.selectedIndex];
    }
}

#pragma CustomLayout的代理方法
- (void)collectioViewScrollToIndex:(NSInteger)index
{
    _selectedIndex = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x < 97) {
        self.actionBtn.alpha = (100 - scrollView.contentOffset.x)  / 100;
    }else if (scrollView.contentOffset.x > 103) {
        self.actionBtn.alpha = (scrollView.contentOffset.x - 100) / 100;
    }

    if (scrollView.contentOffset.x > 100) {
        self.actionBtn.titleLabel.text = @"血压数据 >";
    }else{
        self.actionBtn.titleLabel.text = @"血糖数据 >";
    }

}

// 第一次加载的时候刷新collectionView
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    self.datas = [[NSMutableArray alloc] initWithArray:self.dataSource];
    [self.collectionView reloadData];
}


@end
