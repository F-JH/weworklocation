#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "src/Debug.h"

%hook CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)arg1 didVisit:(CLVisit *)arg2 {[Debug alter:@"didVisit"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didFinishDeferredUpdatesWithError:(NSError *)arg2 {[Debug alter:@"didFinishDeferredUpdatesWithError"]; %orig;}
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)arg1 {[Debug alter:@"locationManagerDidResumeLocationUpdates"]; %orig;}
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)arg1 {[Debug alter:@"locationManagerDidPauseLocationUpdates"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didStartMonitoringForRegion:(CLRegion *)arg2 {[Debug alter:@"didStartMonitoringForRegion"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didChangeAuthorizationStatus:(int)arg2{[Debug alter:@"didChangeAuthorizationStatus"]; %orig;}
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)arg1 {[Debug alter:@"locationManagerDidChangeAuthorization"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 monitoringDidFailForRegion:(CLRegion *)arg2 withError:(NSError *)arg3 {[Debug alter:@"monitoringDidFailForRegion"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didFailWithError:(NSError *)arg2 {[Debug alter:@"didFailWithError"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didExitRegion:(CLRegion *)arg2 {[Debug alter:@"didExitRegion"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didEnterRegion:(CLRegion *)arg2 {[Debug alter:@"didEnterRegion"]; %orig;}
// - (void)locationManager:(CLLocationManager *)arg1 didFailRangingBeaconsForConstraint:(CLBeaconIdentityConstraint *)arg2 error:(NSError *)arg3 {[Debug alter:@"didFailRangingBeaconsForConstraint"]; %orig;}
// - (void)locationManager:(CLLocationManager *)arg1 didRangeBeacons:(NSArray *)arg2 satisfyingConstraint:(CLBeaconIdentityConstraint *)arg3 {[Debug alter:@"didRangeBeacons:satisfyingConstraint"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 rangingBeaconsDidFailForRegion:(CLBeaconRegion *)arg2 withError:(NSError *)arg3 {[Debug alter:@"rangingBeaconsDidFailForRegion"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didRangeBeacons:(NSArray *)arg2 inRegion:(CLBeaconRegion *)arg3 {[Debug alter:@"didRangeBeacons:inRegion"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didDetermineState:(long long)arg2 forRegion:(CLRegion *)arg3 {[Debug alter:@"didDetermineState"]; %orig;}
- (_Bool)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)arg1 {[Debug alter:@"locationManagerShouldDisplayHeadingCalibration"]; return %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didUpdateHeading:(CLHeading *)arg2 {[Debug alter:@"didUpdateHeading"]; %orig;}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {[Debug alter:@"修改定位"]; %orig;}
- (void)locationManager:(CLLocationManager *)arg1 didUpdateToLocation:(CLLocation *)arg2 fromLocation:(CLLocation *)arg3 {[Debug alter:@"didUpdateToLocation"]; %orig;}

%end

%hook WWKLocationRetriever

- (void)locationManager:(id)arg1 didChangeAuthorizationStatus:(int)arg2 {[Debug alter:@"WWKLocationRetriever.locationManager"]; %orig;}
+ (void)fetchAddrWithCoordinate:(struct CLLocationCoordinate2D)arg1 withCallback:(id)arg2 {
    arg1.longitude = 118.17774973;
    arg1.latitude = 24.50076200;
    [Debug alter:@"已修改定位至厦门"];
    %orig;
}

+ (void)fetchAddrWithCoordinateV2:(struct CLLocationCoordinate2D)arg1 withCallback:(id)arg2 {
    arg1.longitude = 118.17774973;
    arg1.latitude = 24.50076200;
    [Debug alter:@"已修改定位至厦门"];
    %orig;
}

%end

%hook WWKLocationRetrieverBaseTask

- (void)locationManager:(id)arg1 didChangeAuthorizationStatus:(int)arg2 {[Debug alter:@"WWKLocationRetrieverBaseTask.locationManager"]; %orig;}
- (void)mapView:(id)arg1 didUpdateUserLocation:(id)arg2 fromHeading:(_Bool)arg3 {
    // 小程序不会使用这个方法获取定位，需要另外分析
    if ([NSStringFromClass([arg2 class]) isEqualToString:@"QUserLocation"]) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:24.50076200 longitude:118.17774973];
        [arg2 setValue:location forKey:@"_location"];
    }
    %orig;
}

%end