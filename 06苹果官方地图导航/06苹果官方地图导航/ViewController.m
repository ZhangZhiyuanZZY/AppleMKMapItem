//
//  ViewController.m
//  06苹果官方地图导航
//
//  Created by 章芝源 on 15/11/5.
//  Copyright © 2015年 ZZY. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>  ///不做也行啊????
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
///地理管理器
@property(nonatomic, strong)CLLocationManager *manager;
///地理编码器
@property(nonatomic, strong)CLGeocoder *geocoder;
@end

@implementation ViewController

#pragma mark - lazy
- (CLLocationManager *)manager
{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
    }
    return _manager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
   
    //1. 申请授权
    [self.manager requestAlwaysAuthorization];
    
    //2. 设置导航参数
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    ///字典中的value不能是基本数据类型?
    dicM[MKLaunchOptionsShowsTrafficKey] = @YES;
    dicM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //3.获得当前位置
    MKMapItem *item1 = [MKMapItem mapItemForCurrentLocation];
    
    //4. 地理解码
    [self.geocoder geocodeAddressString:@"缙云" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        ///从字典中拿出地点信息
        CLPlacemark *place = placemarks.firstObject;
        ///转化成MKPlacemark
        MKPlacemark *placemark = [[MKPlacemark alloc]initWithPlacemark:place];
        
        ///创建终点
        MKMapItem *item2 = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        ///进行导航
        [MKMapItem openMapsWithItems:@[item1, item2] launchOptions:dicM];
    }];

}












@end
