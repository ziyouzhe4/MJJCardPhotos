
#import "MJJMainPopoutView.h"
#import "MJJConstant.h"
#import "NSArray+Extension.h"
#import "UIView+Extension.h"
#import "Masonry.h"
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

- (void)layoutSubviews{

    [super layoutSubviews];

    if (_showRemindBtn) {

        _remindBtn.hidden = NO;

        _actionBtn.frame = CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 60 , 100, 44);

        _remindBtn.frame = CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 115 , 100, 30);


    }else{
        _actionBtn.frame = CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 85 , 100, 44);
        _remindBtn.hidden = YES;
    }


}

// 初始化 设置背景颜色透明点，然后加载子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _selectedIndex = 0;
        self.backgroundColor = RGB(51, 51, 51, 0.5);
        [self addsubviews];
        self.remindBtn.userInteractionEnabled = NO;
    }
    return self;
}

// 加载子视图
- (void)addsubviews{

    [self addSubview:self.collectionView];

    [self addSubview:self.actionBtn];

    [self addRemindBtn];

}

- (void)addRemindBtn{

    [self addSubview:self.remindBtn];
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

- (void)setShowRemindBtn:(BOOL)showRemindBtn{

    _showRemindBtn = showRemindBtn;

}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        MJJCollectionViewFlowLayout *flow = [[MJJCollectionViewFlowLayout alloc] init];//MJJCollectionViewFlowLayout
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(self.width / 2,self.width / 2);
        flow.minimumLineSpacing = 20;
        flow.minimumInteritemSpacing = 20;
        flow.needAlpha = YES;
        flow.delegate = self;
        CGFloat oneX =self.width / 4;
        flow.sectionInset = UIEdgeInsetsMake(20, oneX, 80, oneX);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor clearColor];
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
        _actionBtn.backgroundColor = [UIColor clearColor];
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


- (UIButton *)remindBtn{

    if (!_remindBtn) {
        _remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 115 , 100, 30)];
        _remindBtn.backgroundColor = [UIColor greenColor];
        [_remindBtn setTitle:@"12:59:33" forState:UIControlStateNormal];
        [_remindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    return _remindBtn;
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

        [UIView animateWithDuration:0.4 animations:^{

            self.remindBtn.alpha = (100 - scrollView.contentOffset.x)  / 100;
;
            _actionBtn.frame = CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 85 , 100, 44);

        }];

    }else{
        self.actionBtn.titleLabel.text = @"血糖数据 >";

        [UIView animateWithDuration:0.4 animations:^{

            self.remindBtn.alpha = (100 - scrollView.contentOffset.x)  / 100;
            _actionBtn.frame = CGRectMake(_collectionView.centerX - 50, self.frame.size.height - 60 , 100, 44);
        }];

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
